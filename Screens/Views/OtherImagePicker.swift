//
//  OtherImagePicker.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/5/24.
//

import SwiftUI
import PhotosUI




struct OtherImagePicker: View {
    
    @StateObject var imagePicker = ImageUtility()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let image = imagePicker.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Pick an Image")
                }
            }
            .padding()
            .navigationTitle("Choose a Memory")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(
                        selection: $imagePicker.imageSelection
                        , matching: .images
                    ) {
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    OtherImagePicker()
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
