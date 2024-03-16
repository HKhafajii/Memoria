//
//  OtherImagePicker.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/5/24.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    
    @EnvironmentObject private var viewModel: MemoryViewModel
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
                        selection: $viewModel.memoryService.imageViewModel.imageSelection
                        
                        , matching: .images
                    ) {
                        Image(systemName: "photo")
                            .font(.system(size: 36))
                            .foregroundStyle(.black)
                            .onChange(of: viewModel.memoryService.imageViewModel.imageSelection ) { _, newValue in
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
    ImagePicker()
        .environmentObject(MemoryViewModel(memoryService: MemoryService(recordingViewModel: RecordingListViewModel(dataService: AudioManager()), imageViewModel: ImageUtility())))
}



