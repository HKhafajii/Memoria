//
//  SignIn.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/15/24.
//

import SwiftUI

@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var shared = SignUpWithEmailViewModel()
    
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}

struct SignUpEmailView: View {
    
    @ObservedObject var viewModel = SignUpWithEmailViewModel()
    @Binding var showSignInView: Bool
    @State var emailUsed = false
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
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print("error \(error)")
                    }
                    
                // if there is already an email
                    emailUsed = true
                }
            }, label: {
                Text("Sign Up")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(.buttonBorder)
            })
            
            .alert("Email already in use!", isPresented: $emailUsed) {
                Button("Ok", role: .cancel){}
            }
            
            NavigationLink("Already have an account?") {
                SignInWithEmailView(showSignInView: $showSignInView)
                    .navigationBarBackButtonHidden()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up with Email")
    }
}

#Preview {
    NavigationStack {
        SignUpEmailView(showSignInView: .constant(false))
    }
}
