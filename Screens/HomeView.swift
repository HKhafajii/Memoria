//
//  HomeView.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 1/26/24.
//

import SwiftUI

struct HomeView: View {
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
                    }
                    Spacer()
                
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}



