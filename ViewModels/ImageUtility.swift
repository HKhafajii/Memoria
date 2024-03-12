//
//  ImageUtility.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 3/8/24.
//

import Foundation
import SwiftUI
import PhotosUI
protocol ImageUtilityService {
    
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws
    
}

class ImageUtility: ObservableObject {
    
    @Published var image: Image?
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    
    
    func loadTransferable(from imageSelection: PhotosPickerItem) async throws {

        do {
            if let data = try await imageSelection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print(error.localizedDescription)
            image = nil
        }
    }
    
}
