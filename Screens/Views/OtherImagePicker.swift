//
//  OtherImagePicker.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/5/24.
//

import SwiftUI
import PhotosUI




struct OtherImagePicker: View {
    
    @ObservedObject var imagePicker = MemoryViewModel.shared
    @State var data: Data? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let image = data, let uiImage = UIImage(data: image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    PhotosPicker(
                        selection: $imagePicker.imageViewModel.imageSelection
                        , matching: .images
                    ) {
                        Image(systemName: "photo")
                            .font(.system(size: 36))
                            .foregroundStyle(.black)
                            .onChange(of: imagePicker.imageViewModel.imageSelection) { newValue, _ in
                                guard let item = newValue else {return}
                                item.loadTransferable(type: Data.self) { result in
                                    switch result {
                                    case .success(let data):
                                        if let data = data {
                                            self.data = data
                                            let uuid = UUID().uuidString
                                            let fileName = self.getDocumentsDirectory().appendingPathComponent("\(uuid).png")
                                            try? data.write(to: fileName)
                                        } else {
                                            print("Data is nill")
                                        }
                                    case .failure(let failure):
                                        print("Didn't work \(failure.localizedDescription)")
                                    }
                                }
                            }
                    }
                }
            }
            .padding()
        }
    }
    
    func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
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
