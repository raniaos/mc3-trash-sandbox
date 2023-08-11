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
    
    var onHoldingObject: () -> Void
    var onReleaseTrash: () -> Void
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        context.coordinator.view = arView
        arView.isUserInteractionEnabled = true
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        var anchor = AnchorEntity(plane: .horizontal)
        
        let trashbox = try! Trashbox.loadBox()
        trashbox.generateCollisionShapes(recursive: true)
        anchor.addChild(trashbox)
        
        respawnTrash(anchor: anchor)
        
        arView.scene.addAnchor(anchor)
        
        return arView
    }
    
    func respawnTrash(anchor: AnchorEntity) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let entity = try! Banana.loadBox()
            entity.generateCollisionShapes(recursive: true)
            let coordinate = randomPosition(forceToGround: true)
            entity.position = coordinate ?? randomPosition()
            anchor.addChild(entity)
        }
    }
    
    func randomPosition(forceToGround: Bool = false) -> SIMD3<Float> {
        let x = Float.random(in: -1.0...1.0)
        let y = forceToGround ? Float(0) : Float.random(in: -1.0...1.0)
        let z = Float.random(in: -1.0...1.0)
        
        return SIMD3(x, y, z)
    }
    
    func pickRandomTrash() -> Entity {
        
        let bananaTrash = try! Banana.loadBox()
        let bottleTrash = try! Trashbox.loadBox()
        
        let trashses: [Entity] = [
            bananaTrash.findEntity(named: "Banana") as! Entity,
            bottleTrash.findEntity(named: "TongSampah") as! Entity
        ]
        
        return trashses.randomElement()!
    }
    
    
    func getEntities(withName: String, from: ARView) {
        /*
         1 - Buat loop untuk kumpulin entity dengan nama "withName" di dalam arView.scene.anchors
         2 - kumpulin hasil entities-nya ke dalam sebuah variable
         3 - di dalam array entities tadi, hapus satu2.
         */
        
        //        let entities = from.scene.anchors.first?.findEntity(named: withName)
        //        print(entities)
        
        //        while <#condition#> {
        //            <#code#>
        //        }
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
                    
                    if anchorEntity.findEntity(named: "Banana") != nil {
                        
                        let cameraTransform: Transform = view.cameraTransform
                        let cameraDirection: simd_float3 = cameraTransform.rotation.act(simd_float3(0, 0, -1))
                        let raycastResults: [CollisionCastHit] = view.scene.raycast(origin: cameraTransform.translation, direction:cameraDirection, length: 100)
                        
                        if let firstRaycastResult = raycastResults.first {
                            print("Object distance : \(firstRaycastResult.distance)")
                            if firstRaycastResult.distance <= maxAllowedDistance {
                                view.scene.anchors.first?.findEntity(named: "Banana")?.removeFromParent()
                                parent.onHoldingObject()
                            } else {
                                print("Object too far")
                            }
                        }

                        print(raycastResults)
                    } else if anchorEntity.findEntity(named: "TongSampah") != nil {
                        print("tonggg")
                        parent.onReleaseTrash()
//                        parent.respawnTrash(anchor: anchor)
                    }
                }
                
            }
        }
    }
    
}
