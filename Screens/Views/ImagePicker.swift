////
////  ImagePicker.swift
////  ARApplication
////
////  Created by Hassan Alkhafaji on 1/30/24.
////
//
//import SwiftUI
//import PhotosUI
//
//struct ImagePicker: View {
//    
//    struct ImagePickerData {
//        var selectedItems: [PhotosPickerItem] = []
//        var data: Data?
//       
//    }
//
//    @ObservedObject var viewModel = MemoryViewModel.shared
//    @State var imagePickerData = ImagePickerData()
////    @ObservedObject var viewModel = MemoryViewModel.shared
//    
//    var body: some View {
//        VStack {
//            if let data = imagePickerData.data, let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFill()
//            }
//            
//            Spacer()
//            
//            PhotosPicker(selection: $imagePickerData.selectedItems,
//                         maxSelectionCount: 1
//                         ,matching: .images) {
//                
//                Text("Select a Memory")
//                    .font(.title3)
//                    .foregroundStyle(Color("darkb"))
//                    .padding()
//                    .background(Color("lighto"))
//                    .cornerRadius(12)
//                    .shadow(radius: 10, x: 0.0, y: 8)
//            }
//                         .onChange(of: imagePickerData.selectedItems) { newValue in
//                             guard let item = newValue.first else {return}
//                             item.loadTransferable(type: Data.self) { result in
//                                 switch result {
//                                 case .success(let data):
//                                     if let data = data {
//                                         self.imagePickerData.data = data
//                                         let uuid = UUID().uuidString
//                                         let fileName = self.getDocumentsDirectory().appendingPathComponent("\(uuid).png")
//                                         try? data.write(to: fileName)
//                                         viewModel.imageName = "\(uuid).png"
//                                         print(viewModel.imageName)
//                                     } else {
//                                         print("Data is nill")
//                                     }
//                                 case .failure(let failure):
////                                     fatalError("\(failure)")
//                                     print(failure)
//                                 }
//                             }
//                         }
//            
//        }
//        .padding()
//    }
////    func saveMemory(image: String) {
////        viewModel.addMemory(memory: MemoryModel(id: UUID(), imageName: image, voiceRecording: recordingvm.recordingList))
////    }
//    
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//    
//}
//
//#Preview {
//    ImagePicker()
//}
