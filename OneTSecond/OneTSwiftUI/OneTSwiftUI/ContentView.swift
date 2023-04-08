//
//  ContentView.swift
//  OneTSwiftUI
//
//  Created by Artyom Prima on 03.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Color(red: 34 / 255.0, green: 42 / 255.0, blue: 53 / 255.0)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(spacing: 120) {
                    VStack {
                        Text("Hramkova Julia")
                            .font(.system(size: 34))
                            .foregroundColor(.white)
                        Text("00:02")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    VStack(spacing: 40){
                        HStack(spacing: 50) {
                            VStack{
                                Image("mute")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .imageScale(.small)
                                    .foregroundColor(.accentColor)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 1)
                                            .frame(width: 65, height: 65)
                                    )
                                
                                Text("mute")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.top, 12)
                            }
                            .padding(.leading, 15)
                            VStack{
                                Image("keypad")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .imageScale(.small)
                                    .foregroundColor(.accentColor)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 1)
                                            .frame(width: 65, height: 65)
                                    )
                                
                                Text("keyboard")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.top, 12)
                            }
                            VStack{
                                Image("speaker")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .imageScale(.small)
                                    .foregroundColor(.accentColor)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 1)
                                            .frame(width: 65, height: 65)
                                    )
                                
                                Text("speaker")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.top, 12)
                            }
                        }
                        VStack(spacing: 200) {
                            HStack(spacing: 50) {
                                VStack{
                                    Image("plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .imageScale(.small)
                                        .foregroundColor(.accentColor)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 1)
                                                .frame(width: 65, height: 65)
                                        )
                                    
                                    Text("add")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .padding(.top, 12)
                                }
                                .padding(.leading, 15)
                                VStack{
                                    Circle()
                                        .stroke(Color.white, lineWidth: 1)
                                        .frame(width: 65, height: 65)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .overlay(
                                            Image("FaceTime")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .imageScale(.small)
                                                .foregroundColor(.accentColor)
                                        )
                                    Text("FaceTime")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .padding(.top, 12)
                                }
                                VStack{
                                    Image("woman")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .imageScale(.small)
                                        .foregroundColor(.accentColor)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 1)
                                                .frame(width: 65, height: 65)
                                        )
                                    
                                    Text("contact")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .padding(.top, 12)
                                }
                            }
                            ZStack {
                                Circle()
                                    .stroke(Color.white, lineWidth: 1)
                                    .frame(width: 65, height: 65)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .overlay(
                                        Image("call")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35)
                                            .imageScale(.small)
                                            .foregroundColor(.accentColor)
                                    )
                            }
                        }
                    }
                    .padding(.bottom, 50)
                }
                    .padding()
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
