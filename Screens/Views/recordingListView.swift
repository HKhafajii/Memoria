//
//  recordingListView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/26/24.
//

import SwiftUI

struct recordingListView: View {
    
    @ObservedObject var vm = RecordingListViewModel(dataService: AudioManager())
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(vm.recordingList, id: \.self) { recording in
                        VStack {
                            HStack {
                                Image(systemName: "headphones.circle.fill")
                                    .font(.system(size: 50))
                                VStack(alignment: .leading) {
                                    Text("\(recording.fileURL.lastPathComponent)")
                                }
                                VStack {
                                    Button(action: {
                                        vm.deleteRecording(url: recording.fileURL)
                                    }, label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15))
                                    })
                                    Spacer()
                                    Button(action: {
                                        if recording.isPlaying == true {
                                            vm.stopPlaying(url: recording.fileURL)
                                        } else {
                                            vm.startPlaying(url: recording.fileURL)
                                        }
                                    }, label: {
                                        Image(systemName: recording.isPlaying ? "stop.fill" : "play.fill")
                                    })
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    recordingListView()
}
