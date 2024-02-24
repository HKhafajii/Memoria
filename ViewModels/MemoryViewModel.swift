//
//  MemoryViewModel.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/1/24.
//

import Foundation




class MemoryViewModel: ObservableObject {

    @Published var recordingViewModel = RecordingListViewModel()
    @Published var imageViewModel = ImageUtility()
    @Published var memories: [MemoryModel] = []
    @Published var memory: MemoryModel
    @Published var showingList = false
    static let shared = MemoryViewModel()
    
    private init() {
        memory = MemoryModel(id: UUID())
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





