//
//  MemoryViewModel.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/1/24.
//

import Foundation

protocol MemoryServiceProtocol {
    
    var memory: MemoryModel {get set}
    var memories: [MemoryModel] {get set}
    func addMemory(memory: MemoryModel)
    func fetchAllMemories() -> [MemoryModel]
    func removeMemory(memory: MemoryModel)
    
}

class MemoryService: MemoryServiceProtocol {

    var memories: [MemoryModel] = []
    static let memoriesTest = [MemoryModel(id: UUID())]
    var memory: MemoryModel
    var recordingViewModel: RecordingListViewModel
    var imageViewModel: ImageUtility
    
    
    
    init(memories: [MemoryModel] = memoriesTest, recordingViewModel: RecordingListViewModel, imageViewModel: ImageUtility) {
        self.memories = memories
        self.memory = MemoryModel(id: UUID())
        self.recordingViewModel = recordingViewModel
        self.imageViewModel = imageViewModel
    
    }
    
    func addMemory(memory: MemoryModel) {
        memories.append(memory)
    }
    
    func fetchAllMemories() -> [MemoryModel] {
        return memories
    }
    
    func removeMemory(memory: MemoryModel) {
        if let index = memories.firstIndex(where: { $0.id == memory.id }) {
            memories.remove(at: index)
        }
    }

}

class MemoryViewModel: ObservableObject {

    @Published var memoryService: MemoryService
    @Published var showingList = false
    static let shared = MemoryViewModel(memoryService: MemoryService(recordingViewModel: RecordingListViewModel(dataService: AudioManager()), imageViewModel: ImageUtility()))
    
    
    init(memoryService: MemoryService) {
        self.memoryService = memoryService
    }
}



