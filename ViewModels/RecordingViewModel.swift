//
//  VoiceViewModel.swift
//  FunStuffDetroit
//
//  Created by Hassan Alkhafaji on 1/20/24.
//

import Foundation

class RecordingListViewModel: ObservableObject {
    
    @Published var recordingList = [Recording]()
    
    var audioManager: AudioManagerService
    
    init(dataService: AudioManagerService) {
        self.audioManager = dataService
        fetchAllRecordings()
    }
    
    func fetchAllRecordings() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        for i in directoryContents {
            recordingList.append(Recording(fileURL: i, createdAt: getFile(for: i), isPlaying: false))
        }
        recordingList.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedDescending})
    }
    
    func getFile(for file: URL) -> Date {
        if let attribute = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any], let creationDate = attribute[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    func startPlaying(url: URL) {
        do {
            try audioManager.startPlaying(url: url)
            
            for i in 0..<recordingList.count {
                if recordingList[i].fileURL == url {
                    recordingList[i].isPlaying = true
                }
            }
        } catch {
            // Handle the error
            print("Couldn't play")
        }
    }
    
    func stopPlaying(url: URL) {
        audioManager.stopPlaying(url: url)
            for i in 0..<recordingList.count {
                if recordingList[i].fileURL == url {
                    recordingList[i].isPlaying = false
                }
            
        }
    }
    
    func deleteRecording(url: URL) {
        
        do {
            try audioManager.deleteRecording(url: url)
            for i in 0..<recordingList.count {
                if recordingList[i].isPlaying == true {
                    stopPlaying(url: recordingList[i].fileURL)
                }
                recordingList.remove(at: i)
                
                break
            }
        } catch(let error) {
            print(error)
        }
    }
}

   
