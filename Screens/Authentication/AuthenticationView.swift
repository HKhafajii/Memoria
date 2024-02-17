//
//  AuthenticationView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/16/24.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack {
            
            NavigationLink {
                SignInEmailView()
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
        .navigationTitle("Sign in")
    }
    
}

#Preview {
    NavigationStack {
        AuthenticationView()
    }
}
