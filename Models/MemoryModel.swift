//
//  MemoryModel.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/31/24.
//

import Foundation
import SwiftUI

struct MemoryModel: Identifiable {
    var id: UUID
    var image: Image?
    var voiceRecording: URL?
}


extension MemoryModel: Equatable {
    
    static func == (lhs: MemoryModel, rhs: MemoryModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
