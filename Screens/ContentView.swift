//
//  ContentView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/21/24.
//

import SwiftUI
import RealityKit
import AVFoundation

struct ContentView : View {
    
    @ObservedObject var viewModel = MemoryViewModel.shared
    
    
    var body: some View {
        VStack {
            ARViewContainer()
                .ignoresSafeArea()
                .overlay(
                    Image("SVGLogo")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.35)
                        .clipShape(Rectangle())
                        .frame(maxWidth: 100)
                        .padding()
                    , alignment: .topTrailing
                )
                .overlay(alignment: .center, content: {
                    if let image = viewModel.memory.image {
                        image
                            .resizable()
                            .frame(maxWidth: 350, maxHeight: 350)
                            .onTapGesture {
                                
                                if let url = viewModel.memory.voiceRecording {
                                    viewModel.recordingViewModel.startPlaying(url: url)
                                }
                            }
                    }
                })
                .overlay(
                    ScrollView(.horizontal) {
                        HStack {
                            Button {
                                viewModel.showingList.toggle()
                            } label: {
                                Image(systemName: "plus.square.fill.on.square.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color("lighto"))
                                    .padding()
                            }
                            
                            .sheet(isPresented: $viewModel.showingList, content: {
                                CreateMemoriaView()
                            })
                            
                            
                            ForEach(viewModel.memories) { index in
                                if let image = index.image {
                                    image
                                        .resizable()
                                        .frame(maxWidth: 75)
                                        .onTapGesture {
                                            viewModel.memory = index
                                        }
                                    
                                }
                            }
                        }
                    }
                        .frame(maxHeight: 75)
                        .background(.ultraThinMaterial)
                    , alignment: .bottom)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Create a cube model
        //        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        //        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
        //        let model = ModelEntity(mesh: mesh, materials: [material])
        
        // Create horizontal plane anchor for the content
        //        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        //        anchor.children.append(model)
        
        // Add the horizontal plane anchor to the scene
        //        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
