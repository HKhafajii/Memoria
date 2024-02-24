//
//  AuthenticationView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/16/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                
                NavigationLink {
                    SignUpEmailView(showSignInView: $showSignInView)
                } label: {
                    Text("Sign In With Email")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(12)
                }
                Spacer()
                
            }
            .padding()
            .navigationTitle("Sign Up")
        }
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
}
