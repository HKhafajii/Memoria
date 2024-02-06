//
//  ContentView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/21/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @ObservedObject var viewModel = MemoryViewModel.shared
//    var logoSize: CGSize = 12.0
    
    var body: some View {
        VStack {
            ARViewContainer()
                .ignoresSafeArea()
                .overlay(
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.35)
                    .frame(maxWidth: 75)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                    .padding()
                , alignment: .topLeading
                )
                .overlay(
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.memories) { index in
                                Text("\(index.id)")
                            }
                        }
                    }
                        .background(.ultraThinMaterial)
                    , alignment: .bottom)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        // Create a cube model
        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
        let model = ModelEntity(mesh: mesh, materials: [material])

        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(model)

        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
