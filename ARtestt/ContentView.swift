//
//  ContentView.swift
//  ARtestt
//
//  Created by Rania Ori Sumargo on 01/08/23.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
            .overlay(alignment: .bottom) {
                Button {
                    print("aaa")
                } label: {
                    Image(systemName: "trash")
                        .frame(width: 40, height: 40)
                }
            }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @State var holdingObject: Bool = false
    @State var trashesThrown: Int = 0
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        context.coordinator.view = arView
        arView.isUserInteractionEnabled = true

        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let trashbox = try! Trashbox.loadBox()
        trashbox.generateCollisionShapes(recursive: true)
        anchor.addChild(trashbox)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let entity = try! Banana.loadBox()
            entity.generateCollisionShapes(recursive: true)
            let coordinate = randomPosition(forceToGround: true)
            entity.position = coordinate ?? randomPosition()
            anchor.addChild(entity)
        }
        
        arView.scene.addAnchor(anchor)
        print(arView.scene.anchors)
        
        return arView
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
            Coordinator()
        }

    class Coordinator: NSObject {
        weak var view: ARView?
        
        @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            guard let view = self.view else { return }
            
            let tapLocation = recognizer.location(in: view)
            
            if let entity = view.entity(at: tapLocation) as? ModelEntity {
                if let anchorEntity = entity.anchor {
                    if anchorEntity.findEntity(named: "Banana") != nil {
                        view.scene.anchors.first?.findEntity(named: "Banana")?.removeFromParent()
                        
                    }
                    else if anchorEntity.findEntity(named: "TongSampah") != nil {
                        print("tonggg")
                    }
                }
            }
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
