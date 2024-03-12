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
    @ObservedObject var viewModel: MemoryViewModel
    
    init(service: MemoryService) {
        _viewModel = ObservedObject(wrappedValue: MemoryViewModel(memoryService: service))
    }

    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("bg")
                    .ignoresSafeArea()
                VStack {
                    Button(action: {
                        viewModel.memoryService.recordingViewModel.fetchAllRecordings()
                        viewModel.memoryService.addMemory(memory: MemoryModel(id: UUID(), image: viewModel.memoryService.imageViewModel.image, voiceRecording: viewModel.memoryService.recordingViewModel.recordingList.first?.fileURL))
                        // this is view-related
                        viewModel.showingList.toggle()
                    }, label: {
                        Text("Create Memoria!")
                            .foregroundStyle(Color("darkb"))
                            .font(.system(size: 32))
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal)
                            .background(Color("lighto"))
                            .clipShape(Capsule())
                            .padding(.top, 8)
                    })

                    Spacer()

                    VStack {
                        Spacer()
                        ImagePicker(service: MemoryService(recordingViewModel: RecordingListViewModel(dataService: AudioManager()), imageViewModel: ImageUtility()))
                        Spacer()
                        RecordView(service: MemoryService(recordingViewModel: RecordingListViewModel(dataService: AudioManager()), imageViewModel: ImageUtility()))
                    }
                }
            }
        }
    }
}

#Preview {
    CreateMemoriaView(service: MemoryService(recordingViewModel: RecordingListViewModel(dataService: AudioManager()), imageViewModel: ImageUtility()))
}

struct RecordView: View {
    
    @State var isRecording = false
    
    @State private var showingAlert = false
    
    @ObservedObject private var vm: MemoryViewModel
    
    init(service: MemoryService) {
        _vm = ObservedObject(wrappedValue: MemoryViewModel(memoryService: MemoryService(recordingViewModel: RecordingListViewModel(dataService: AudioManager()), imageViewModel: ImageUtility())))
    }
    
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
                                try vm.memoryService.recordingViewModel.audioManager.startRecording()
                               
                            } catch {
                                print("The start recording function didnt work")
                                recordingFailed = true
                            }
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isRecording.toggle()
                            }
                        } else {
                            vm.memoryService.recordingViewModel.audioManager.stopRecording()
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
            .padding()
            .clipShape(Capsule())
            .background(Color("lighto"))
            .cornerRadius(12)
            .shadow(radius: 10, x: 0.0, y: 10)
        }
    }
}



