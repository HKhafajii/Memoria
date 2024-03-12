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
    
    @EnvironmentObject private var viewModel: MemoryViewModel
    
    
//    init(service: MemoryService) {
//        _viewModel = ObservedObject(wrappedValue: MemoryViewModel(memoryService: service))
//    }
    
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
                    if let image = viewModel.memoryService.memory.image  {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .onTapGesture {
                                print("started")
                                if let url = viewModel.memoryService.memory.voiceRecording {
                                    viewModel.memoryService.recordingViewModel.startPlaying(url: url)
                                    
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
                            
                            
                            ForEach(viewModel.memoryService.memories) { memory in
                                if let image = memory.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                        .onTapGesture {
                                            viewModel.memoryService.memory = memory
                                            print("Made into memory")
                                        }
                                }
                            } // End ForEach
                        }
                    }
                        .frame(maxHeight: 100)
                        .background(.ultraThinMaterial),
                         alignment: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.scene.anchors.removeAll()
        
        let url = URL(fileURLWithPath: "/Users/khafaajii/Documents/Development/ARApplication/ARApplication/Preview Content/PictureFrame.usdz")
        let entity = try? Entity.load(contentsOf: url)
        
        let modelAnchor = AnchorEntity()

        if let modelEntity = entity {
            modelAnchor.addChild(modelEntity)
        }
        
        modelAnchor.position = [-0, 0, -1]
        arView.scene.addAnchor(modelAnchor)
       
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
     
}
#Preview {
    ContentView()
        .environmentObject(MemoryViewModel(memoryService: MemoryService(recordingViewModel: RecordingListViewModel(dataService: AudioManager()), imageViewModel: ImageUtility())))
}



