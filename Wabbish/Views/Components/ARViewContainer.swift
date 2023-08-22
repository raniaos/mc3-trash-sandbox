//
//  ARViewContainer.swift
//  ARtestt
//
//  Created by David Mahbubi on 11/08/23.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ARViewContainer: UIViewRepresentable {
    
    @State var trashesThrown: Int = 0
    @State var isHoldingObject: Bool = false
    @State var objectName: String = ""
    @State var holdedTrash: HoldedTrash? = nil
    
    var onHoldingObject: (_ trash: HoldedTrash) -> Void
    var onReleaseTrash: () -> Void
    var onFalseTrash: () -> Void
    var onTrueTrash: () -> Void
    var onTrashTooFar: () -> Void
    
    @Binding var itemLeft: Int
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        context.coordinator.view = arView
        arView.isUserInteractionEnabled = true
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let b3TrashBox = try! B3TrashBox.loadBox()
        b3TrashBox.generateCollisionShapes(recursive: true)
        anchor.addChild(b3TrashBox)
        
        var position: SIMD3<Float>? = b3TrashBox.findEntity(named: "B3TrashBox")?.position
        
        position?.x -= 1
        
        let paperTrashBox = try! PaperTrashBox.loadBox()
        paperTrashBox.generateCollisionShapes(recursive: true)
        (paperTrashBox.findEntity(named: "PaperTrashBox")!).position = position!
        anchor.addChild(paperTrashBox)
        
        position?.x += 0.5
        
        let organic = try! OrganicTrashBox.loadBox()
        organic.generateCollisionShapes(recursive: true)
        (organic.findEntity(named: "OrganicTrashBox")!).position = position!
        anchor.addChild(organic)
        
        position?.x += 1

        let anorganicTrashBox = try! AnorganicTrashBox.loadBox()
        anorganicTrashBox.generateCollisionShapes(recursive: true)
        (anorganicTrashBox.findEntity(named: "AnorganicTrashBox")!).position = position!
        anchor.addChild(anorganicTrashBox)
        
        position?.x += 0.5
        
        let residuTrashBox = try! ResiduTrashBox.loadBox()
        residuTrashBox.generateCollisionShapes(recursive: true)
        (residuTrashBox.findEntity(named: "ResiduTrashBox")!).position = position!
        anchor.addChild(residuTrashBox)
        
        respawnTrash(from: arView)
        
        arView.scene.addAnchor(anchor)
        return arView
    }
    
    func respawnTrash(from: ARView) -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let anchor = AnchorEntity(plane: .horizontal)
            let entity = pickRandomTrash()
            entity.generateCollisionShapes(recursive: true)
            let coordinate = randomPosition(forceToGround: true)
            entity.position = coordinate
            anchor.addChild(entity)
            from.scene.addAnchor(anchor)
        }
    }
    
    func randomPosition(forceToGround: Bool = false) -> SIMD3<Float> {
        let x = Float.random(in: -1.0...1.0)
        let y = forceToGround ? Float(0) : Float.random(in: -1.0...1.0)
        let z = Float.random(in: -1.0...1.0)
        
        return SIMD3(x, y, z)
    }
    
    func pickRandomTrash() -> Entity {
        
        let bananaTrash = try! Bananafix.loadScene()
        let batteryTrash = try! Battery.loadBox()
        let bottleTrash = try! Bottle.loadBox()
        let maskTrash = try! Mask.loadBox()
        let paper = try! Paper.loadBox()
        
        let trashses: [Entity] = [
            bananaTrash.findEntity(named: "Banana")!,
            batteryTrash.findEntity(named: "Battery")!,
            bottleTrash.findEntity(named: "Bottle")!,
            maskTrash.findEntity(named: "Mask")!,
            paper.findEntity(named: "Paper")!
        ]
        
        return trashses.randomElement()!
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        
        let parent: ARViewContainer
        weak var view: ARView?
        
        init(parent: ARViewContainer) {
            self.parent = parent
        }
        
        @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            
            let tapLocation = recognizer.location(in: view)
            let maxAllowedDistance: Float = 1.3
            
            guard let view = self.view else { return }
            
            if let entity = view.entity(at: tapLocation) as? ModelEntity {
                
                if let anchorEntity = entity.anchor {
                    
                    let cameraTransform: Transform = view.cameraTransform
                    let cameraDirection: simd_float3 = cameraTransform.rotation.act(simd_float3(0, 0, -1))
                    
                    let raycastResults: [CollisionCastHit] = view.scene.raycast(
                        origin: cameraTransform.translation,
                        direction: cameraDirection,
                        length: 100
                    )
                    
                    if let firstRaycastResult = raycastResults.first {
                        
                        if firstRaycastResult.distance <= maxAllowedDistance {
                            
                            var isTrashBin: Bool = false
                            
                            for trashCategory in trashBinCategories {
                                if (anchorEntity.findEntity(named: trashCategory.value) != nil) {
                                    if (parent.isHoldingObject) {
                                        parent.onReleaseTrash()
                                        if parent.holdedTrash?.category != trashCategory.key {
                                            parent.onFalseTrash()
                                        } else {
                                            parent.onTrueTrash()
                                        }
                                        parent.isHoldingObject = false
                                        if parent.itemLeft > 0 {
                                            parent.respawnTrash(from: view)
                                        }
                                        isTrashBin = true
                                    }
                                }
                            }
                            if (!isTrashBin) {
                                for trashCategory in trashCategories {
                                    for trashName in trashCategory.value {
                                        if (anchorEntity.findEntity(named: trashName) != nil) {
                                            parent.holdedTrash = HoldedTrash(name: trashName, icon: "")
                                            parent.onHoldingObject(parent.holdedTrash!)
                                            parent.isHoldingObject = true
                                            view.scene.anchors.remove(at: 1)
                                        }
                                    }
                                }
                            }
                        } else {
                            parent.onTrashTooFar()
                        }
                    }
                }
            }
        }
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
