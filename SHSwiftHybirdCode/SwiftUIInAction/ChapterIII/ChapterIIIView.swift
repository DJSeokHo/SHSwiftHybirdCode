//
//  ChapterIIIView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//
//  My first app

import SwiftUI
import AVFoundation

struct ChapterIIIDelegate {
    
    var onFinish: () -> Void
    
}

struct ChapterIIIView: View {
    
    var delegate: ChapterIIIDelegate
    
    var body: some View {
        
        ZStack(alignment: .top, content: {
            
            Color
                .black
            
            VStack {
                
                Spacer()
                    .frame(height: 50)
                
                TopAppBarView(
                    trailingImageName: "xmark",
                    trailingColor: "#FFFFFF",
                    backgroundColor: "#000000",
                    onTrailingClick: {
                        delegate.onFinish()
                    }
                )
                
                Spacer()
                    .frame(height: 20)
                
                HeartView()
                
                topView
                bottomView
                
            }
            
        })
        .ignoresSafeArea()
    
    }
    
    private var topView: some View {
        
        Button(action: {
         
            speak(text: "Happy Programming")
            
        }, label: {
          
            Text("Happy Programming")
                .fontWeight(.bold)
                .font(.system(.title, design: .rounded))
            
        })
        .padding()
        .foregroundColor(.white)
        .background(Color.yellow)
        .cornerRadius(20)
        
    }
    
    private var bottomView: some View {
            
        Button(action: {
            
           speak(text: "Hello World")
            
        }, label: {
          
            Text("Hello World")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(.title, design: .rounded))
            
        })
        .padding()
        .background(Color.purple)
        .cornerRadius(20)
        
    }
    
    private func speak(text: String) {
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        
    }
    
}

private struct HeartView: View {
    
    @State
    private var colorChange = false
    
    @State
    private var sizeChange = false
    
    var body: some View {
        
        Image(systemName: "heart.fill")
            .font(.system(size: 200))
            .foregroundColor(colorChange ? .yellow : .red)
            .scaleEffect(sizeChange ? 1.5 : 1)
            .animation(.default)
            .onTapGesture {
                self.colorChange.toggle()
            }
            .onLongPressGesture {
                self.sizeChange.toggle()
            }
        
    }
    
}

struct ChapterIIIView_Previews: PreviewProvider {
    static var previews: some View {
       
        ChapterIIIView(
            delegate: ChapterIIIDelegate(
                onFinish: {
                    
                }
            )
        )
        
    }
}
