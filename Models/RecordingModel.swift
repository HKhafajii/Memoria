//
//  File.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/25/24.
//

import Foundation

struct Recording: Hashable, Equatable {
    let fileURL: URL
    let createdAt: Date
    var isPlaying: Bool
}


