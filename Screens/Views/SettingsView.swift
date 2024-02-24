//
//  SettingsView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/22/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
       try AuthenticationManager.shared.signOut()
    }
    
}

struct SettingsView: View {
    
    var lighto: Color = Color("lighto")
    var darkb: Color = Color("darkb")
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
            VStack {
                
//                    Text("Settings")
//                        .font(.largeTitle)
//                        .foregroundStyle(darkb)
//                        .padding()
                
                    Spacer()
                
                List {
                    Button(action: {
                        Task {
                            do {
                               try viewModel.signOut()
                                showSignInView = true
                            } catch {
                                print("Error signing out, try again!")
                            }
                        }
                    }, label: {
                        Text("LOGOUT")
                    })
                }
                .listStyle(.plain)
                .listRowSpacing(40)
                
                Spacer()
                
            }
            .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
