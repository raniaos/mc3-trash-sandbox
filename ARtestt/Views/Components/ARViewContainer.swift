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
    
    var onHoldingObject: () -> Void
    var onReleaseTrash: () -> Void
    var onFalseTrash: () -> Void
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
//        arView.debugOptions = [.showPhysics]
        context.coordinator.view = arView
        arView.isUserInteractionEnabled = true
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let b3 = try! B3TrashBox.loadBox()
        b3.generateCollisionShapes(recursive: true)
        anchor.addChild(b3)
        
        var position: SIMD3<Float>? = b3.findEntity(named: "B3")?.position
        position?.x -= 0.5
        
        let organic = try! OrganicTrashBox.loadBox()
        organic.generateCollisionShapes(recursive: true)
        (organic.findEntity(named: "Organic")!).position = position!
        anchor.addChild(organic)
        
        respawnTrash(from: arView)
        
        arView.scene.addAnchor(anchor)
        return arView
    }
    
    func respawnTrash(from: ARView) {
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
        
        let bananaTrash = try! Banana2.loadScene()
        let batteryTrash = try! Battery.loadBox()
//        let bottleTrash = try! Bottle.loadBox()
        let maskTrash = try! Mask.loadBox()
        
        let trashses: [Entity] = [
            bananaTrash.findEntity(named: "banana")!,
            batteryTrash.findEntity(named: "Battery")!,
//            bottleTrash.findEntity(named: "Bottle") as! Entity,
            maskTrash.findEntity(named: "Mask")!
        ]
        
        return trashses.randomElement()!
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
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
            guard let view = self.view else { return }
            let tapLocation = recognizer.location(in: view)
            let maxAllowedDistance: Float = 1.3
            
            if let entity = view.entity(at: tapLocation) as? ModelEntity {
                
                if let anchorEntity = entity.anchor {
                    
                    let cameraTransform: Transform = view.cameraTransform
                    let cameraDirection: simd_float3 = cameraTransform.rotation.act(simd_float3(0, 0, -1))
                    let raycastResults: [CollisionCastHit] = view.scene.raycast(origin: cameraTransform.translation, direction:cameraDirection, length: 100)
                    
                    if let firstRaycastResult = raycastResults.first {
                        print("Object distance : \(firstRaycastResult.distance)")
                        if firstRaycastResult.distance <= maxAllowedDistance {
                            if anchorEntity.findEntity(named: "Paper") != nil {
                                print("sampah paper")
                                if parent.isHoldingObject {
                                    if parent.objectName != "Paper" {
                                        parent.onFalseTrash()
                                    }
                                    parent.onReleaseTrash()
                                    parent.respawnTrash(from: view)
                                    parent.isHoldingObject = false
                                }
                            }
                            else if anchorEntity.findEntity(named: "Organic") != nil {
                                print("sampah organic")
                                if parent.isHoldingObject {
                                    if parent.objectName != "Banana" {
                                        parent.onFalseTrash()
                                    }
                                    parent.onReleaseTrash()
                                    parent.respawnTrash(from: view)
                                    parent.isHoldingObject = false
                                }
                            }
                            else if anchorEntity.findEntity(named: "B3") != nil {
                                print("sampah b3")
                                if parent.isHoldingObject {
                                    if parent.objectName != "Battery" {
                                        parent.onFalseTrash()
                                    }
                                    parent.onReleaseTrash()
                                    parent.respawnTrash(from: view)
                                    parent.isHoldingObject = false
                                }
                            }
                            else if anchorEntity.findEntity(named: "Anorganic") != nil {
                                print("sampah anorganic")
                                if parent.isHoldingObject {
                                    if parent.objectName != "Bottle" {
                                        parent.onFalseTrash()
                                    }
                                    parent.onReleaseTrash()
                                    parent.respawnTrash(from: view)
                                    parent.isHoldingObject = false
                                }
                            }
                            else if anchorEntity.findEntity(named: "Residu") != nil {
                                print("sampah residu")
                                if parent.isHoldingObject {
                                    if parent.objectName != "Mask" {
                                        parent.onFalseTrash()
                                    }
                                    parent.onReleaseTrash()
                                    parent.respawnTrash(from: view)
                                    parent.isHoldingObject = false
                                }
                            }
                            else {
                                if anchorEntity.findEntity(named: "banana") != nil {
                                    parent.objectName = "Banana"
                                    print("Banana")
                                }
                                else if anchorEntity.findEntity(named: "Bottle") != nil {
                                    parent.objectName = "Bottle"
                                    print("Bottle")
                                }
                                else if anchorEntity.findEntity(named: "Battery") != nil {
                                    parent.objectName = "Battery"
                                    print("Battery")
                                }
                                else if anchorEntity.findEntity(named: "Paper") != nil {
                                    parent.objectName = "Paper"
                                    print("Paper")
                                }
                                else if anchorEntity.findEntity(named: "Mask") != nil {
                                    parent.objectName = "Mask"
                                    print("Mask")
                                }
                                view.scene.anchors.remove(at: 1)
                                parent.onHoldingObject()
                                parent.isHoldingObject = true
                            }
                        }
                        print("")
                    }
                }
            }
        }
    }
    
}
