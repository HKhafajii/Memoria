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
                        .frame(width: 300, height: 300)
                        .cornerRadius(120)
                        .shadow(radius: 10, x: 0, y: 8)
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
                        .frame(width: 250)
                        .padding()
                        .background(Color("lighto"))
                        .cornerRadius(12)
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



