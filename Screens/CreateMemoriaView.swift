//
//  RecordingView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/25/24.
//

import SwiftUI
import AVFoundation

struct CreateMemoriaView: View {
    
    @State private var showingList = false
    @ObservedObject var viewModel = MemoryViewModel.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("bg")
                VStack {
                    Button(action: {
                        viewModel.addMemory(memory: MemoryModel(id: UUID(), image: viewModel.imageViewModel.image, voiceRecording: viewModel.recordingViewModel.recordingList.first?.fileURL))
                        showingList.toggle()
                    }, label: {
                        Text("Create Memoria!")
                            .foregroundStyle(Color("darkb"))
                            .font(.system(size: 36))
                            .padding()
                            .background(Color("lighto"))
                            .clipShape(Capsule())
                            .padding(.top, 8)
                    })
                    
                    Spacer()
                    
                    VStack {
                        //  ImagePicker()
                        OtherImagePicker()
                        Spacer()
                        RecordView()
                        
                        
                       

                        
                    }
                }
            }
        }
    }
}

#Preview {
    CreateMemoriaView()
}

struct RecordView: View {
    
    @State var isRecording = false
    
    @State private var showingAlert = false
    
    @ObservedObject var vm = MemoryViewModel.shared
    
    @State var recordingFailed = false
    
    var body: some View {
        ZStack {
  
    
            HStack {
                Text("Record your message")
                    .foregroundStyle(Color("darkb"))
                Image(systemName: isRecording ? "pause.circle": "mic.circle")
                    .font(.system(size: 48))
                    .foregroundStyle(Color("darkb"))
                    .onTapGesture {
                        if isRecording == false {
                            do {
                                try vm.recordingViewModel.audioManager.startRecording()
                            } catch {
                                print("The start recording function didnt work")
                                recordingFailed = true
                            }
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isRecording.toggle()
                            }
                        } else {
                            vm.recordingViewModel.audioManager.stopRecording()
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isRecording.toggle()
                            }
                            // MARK: try to find where you've saved the recording url and put it here
//                            let memory = MemoryModel(id: UUID(), imageName: vm.imageName, voiceRecording: vm.recordingViewModel.audioManager.)
                            
                        }
                    }//End onTap
                
                    .alert("Could not record", isPresented: $recordingFailed) {
                        Button("dismiss") {}
                    }
            }
            .font(.title3)
            .frame(width: 350, height: 75)
            .background(Color("lighto"))
            .cornerRadius(12)
            .shadow(radius: 10, x: 0.0, y: 10)
        }
    }
}



