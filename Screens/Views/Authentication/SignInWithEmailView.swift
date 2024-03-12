//
//  SignInWithEmailView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/23/24.
//

import SwiftUI

struct SignInWithEmailView: View {
    
    @StateObject private var viewModel = SignUpWithEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.lighto
                    .opacity(0.35)
                    .ignoresSafeArea()
                
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
                            // sign in action
                            do {
                                try await viewModel.signIn()
                                showSignInView = false
                                return
                            } catch {
                                print("error \(error)")
                            }
                        }
                    }, label: {
                        Text("Sign In")
                            .foregroundStyle(.lighto)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .background(.darkb)
                            .clipShape(.buttonBorder)
                            .shadow(radius: 10, x: 0, y: 10)
                    })
                    
                    NavigationLink("Don't have an account?") {
                        SignUpEmailView(showSignInView: $showSignInView)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        SignInWithEmailView(showSignInView: .constant(false))
    }
}
