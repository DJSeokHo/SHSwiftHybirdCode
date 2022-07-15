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
            
            Color
                .black
                
            VStack {
                
                Text("This is a hybird code")
                    .foregroundColor(.white)
                    .font(.system(size: 25, design: .rounded))
                    .fontWeight(.bold)
                
                chapterIIIView
                
                chapterIVView
            }
        }
        .ignoresSafeArea()
        
    }
    
    private var chapterIVView: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 10)
            
            Button(action: {
                
            }, label: {
                
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
            })
            
        }
    }
    
    private var chapterIIIView: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 10)
            
            Button(action: {
                
            }, label: {
                
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
            })
            
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
