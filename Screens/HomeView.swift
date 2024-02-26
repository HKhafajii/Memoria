//
//  HomeView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/26/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var isAnimating = false
    @State private var showSignInView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("bg").ignoresSafeArea()
                VStack(spacing: -100) {
                    
                   
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 100, height: 100)))
                        .shadow(radius: 10, x: 0, y: 8)
                        .offset(x: isAnimating ? 0 : 400)
                        .animation(.easeInOut(duration: 1), value: isAnimating)
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink {
                        ContentView()
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "eye")
                                .padding()
                            Text("View \nMemoria")
                        }
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundStyle(Color("darkb"))
                        .padding()
                        .background(Color("lighto"))
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
                        .padding()
                        .shadow(radius: 10, x: 0, y: 8)
                        .offset(y: isAnimating ? 0 : 350)
                        .animation(.easeInOut(duration: 1.5), value: isAnimating)
                    }
                    // End of navigation link
                    
                    Spacer()
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView)
                    } label: {
                        Text("Settings")
                    }
                
                } // End of Vstack
            } // End of Zstack
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:  {
                    isAnimating = true
                })
            })
            .navigationTitle("Home")
            .toolbar(.hidden)
            // End of animation onAppear
        } // End of Navigation Stack
        .ignoresSafeArea()
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true : false
        } // End of onAppear
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        } // End of fullscreencover
    }
}

#Preview {
    HomeView()
}
