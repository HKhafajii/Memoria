//
//  MemoryViewModel.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/1/24.
//

import Foundation


class MemoryViewModel: ObservableObject {

    @Published var recordingViewModel = RecordingListViewModel()
    @Published var memories: [MemoryModel] = []
    @Published var memory: MemoryModel
    @Published var imageName: String = ""
    static let shared = MemoryViewModel()
    
    private init() {
        memory = MemoryModel(id: UUID(), imageName: "Test")
    }
    
    func addMemory(memory: MemoryModel) {
        memories.append(memory)
    }
    
    func removeMemory(memory: MemoryModel) {
        if let index = memories.firstIndex(where: { $0.id == memory.id }) {
            memories.remove(at: index)
        }
    }
}


