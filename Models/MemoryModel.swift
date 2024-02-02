//
//  MemoryModel.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/31/24.
//

import Foundation

struct MemoryModel: Identifiable {
    var id: UUID
    var imageName: String
    var voiceRecording: Recording?
    var createdRecording: Recording?
}
    
