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
                        .clipShape(Rectangle())
                        .frame(maxWidth: 100)
                        .padding()
                        .padding([.trailing, .top], 20)
                   
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
        .ignoresSafeArea()
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
