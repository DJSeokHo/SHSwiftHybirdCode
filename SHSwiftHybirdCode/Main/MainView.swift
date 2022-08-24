//
//  MainView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import SwiftUI

struct MainView: View {
    
    var onButtonClick: (_ buttonContent: String) -> Void
    
    var body: some View {
        
        ZStack {
            
            Color.black
                
            List {
                
                Spacer()
                    .frame(height: 50)
                    .listRowBackground(Color.black)
                
                Text("This is a hybird code")
                    .foregroundColor(.white)
                    .font(.system(size: 25, design: .rounded))
                    .fontWeight(.bold)
                    .listRowBackground(Color.black)
                
                chapterIIIView
                    .listRowBackground(Color.black)
                      
                chapterIVView
                    .listRowBackground(Color.black)
                
                chapterVIView
                    .listRowBackground(Color.black)
                
                chapterXXView
                    .listRowBackground(Color.black)
                
                Spacer()
                    .frame(height: 50)
                    .listRowBackground(Color.black)
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea()
        
    }
    
    private var chapterXXView: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 10)
            
            Button(action: {
                
                onButtonClick("Chapter 20")
                
            }, label: {
                
                Text("Chapter 20")
                    .font(.system(size: 20, design: .rounded))
                
            })
            .foregroundColor(.white)
            .padding()
            .background(Color.purple)
            .cornerRadius(10)
        }
    }
    
    private var chapterVIIView: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 10)
            
            Button(action: {
                
                onButtonClick("Chapter 7")
                
            }, label: {
                
                Text("Chapter 7")
                    .font(.system(size: 20, design: .rounded))
                
            })
            .foregroundColor(.white)
            .padding()
            .background(Color.purple)
            .cornerRadius(10)
        }
    }
    
    private var chapterVIView: some View {

        VStack {

            Spacer()
                .frame(height: 10)

            Button(action: {

                onButtonClick("Chapter 6")
                
            }, label: {

                Text("Chapter 6")
                    .font(.system(size: 20, design: .rounded))
                
            })
            .foregroundColor(.white)
            .padding()
            .background(Color.purple)
            .cornerRadius(10)

        }
    }
    
    private var chapterIVView: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 10)
            
            HStack {
                
                Button(action: {
                    
                    onButtonClick("Chapter 4")
                    
                }, label: {
                    
                    Text("Chapter 4")
                        .font(.system(size: 20, design: .rounded))
                    
                })
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
                
                Button(action: {
                    
                    onButtonClick("Chapter 4 HW")
                    
                }, label: {
                    
                    Text("Chapter 4 HW")
                        .font(.system(size: 20, design: .rounded))
                    
                })
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
            }
            
            
        }
    }
    
    private var chapterIIIView: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 10)
            
            Button(action: {
                
                onButtonClick("Chapter 3")
                
            }, label: {
                
                Text("Chapter 3")
                    .font(.system(size: 20, design: .rounded))
                
            })
            .foregroundColor(.white)
            .padding()
            .background(Color.purple)
            .cornerRadius(10)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            onButtonClick: { buttonContent in
                
            }
        )
    }
}
