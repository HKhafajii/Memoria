//
//  SignIn.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/15/24.
//

import SwiftUI

@MainActor
final class SignInWithEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signin() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        AuthenticationManager.shared
        
    }
}

struct SignInEmailView: View {
    
    @StateObject var viewModel = SignInWithEmailViewModel()
    
    var body: some View {
        VStack(spacing: 50) {
            
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(.buttonBorder)
                
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(.buttonBorder)
                
            
            Button(action: {
                
            }, label: {
                Text("Sign In")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(.buttonBorder)
            })
            Spacer()
        }
        .padding()
        .navigationTitle("Sign in with Email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView()
    }
}
