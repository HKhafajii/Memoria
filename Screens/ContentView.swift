//
//  ContentView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/21/24.
//

import SwiftUI
import ARKit
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
                        .clipShape(Rectangle())
                        .frame(maxWidth: 100)
                        .padding()
                        .padding(.top, 40)
                   
                    , alignment: .topTrailing
                    
                )
                .overlay(alignment: .center, content: {
                    if let image = viewModel.memory.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
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
                                        .scaledToFit()

                                        .padding()
                                        .onTapGesture {
                                            viewModel.memory = index
                                        }
                                    
                                }
                            }
                        }
                    }
                        .frame(maxHeight: 100)
                        .background(.ultraThinMaterial)
                    , alignment: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel = MemoryViewModel.shared
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.scene.anchors.removeAll()

        
        // finish doing this
//        let uiImage = {
//            
//        }

        
        let modelEntity = try! ModelEntity.loadModel(named: "PictureFrame.usdz")
        
        
        
        let modelAnchor = AnchorEntity()
        modelAnchor.addChild(modelEntity)
        
        modelAnchor.position = [-0, 0, -1]
        
        arView.scene.addAnchor(modelAnchor)
       
        var materials = SimpleMaterial()
        
        
        
        
        materials.color = .init(tint: .white.withAlphaComponent(0.999), texture: .init(try! .load(named: "logo2")))
        materials.metallic = .float(1.0)
        materials.roughness = .float(0.0)
        
        let imageEntity = ModelEntity(mesh: .generateBox(width: 2.0, height: 2.0, depth: 0.01), materials: [materials])
        
        imageEntity.position.z -= 2
        imageEntity.position.y -= 2
        imageEntity.position.x -= 1
        
        imageEntity.setParent(modelAnchor)
        arView.scene.addAnchor(modelAnchor)
        
        
    
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
     
}

#Preview {
    ContentView()
}


//extension ARView {
//    
//    func enableTapGesture() {
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
//        self.addGestureRecognizer(tap)
//        
//    }
//    
//    func handleTap(recognizer: UITapGestureRecognizer) {
//        
//        let tapLocation = recognizer.location(in: self)
//        
//        
//        guard let rayResult = self.ray(through: tapLocation) else {return}
//    }
//    
//    let results = self.scene.raycast(origin: rayResult., direction: <#T##SIMD3<Float>#>)
//    
//}
