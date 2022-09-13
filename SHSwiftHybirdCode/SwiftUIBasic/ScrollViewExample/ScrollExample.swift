//
//  ScrollViewExample.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import SwiftUI

struct ScrollViewExample: View {
    
    var body: some View {
        
//        vScroll
//        hScroll
        hvScroll
    }
    
    var hvScroll: some View {
        
        ZStack {
            
            Color
                .black
                .ignoresSafeArea()
            
            
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                Text("Item Item Item")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(width: 600, height: 600)
                    .background(Color.red)
            }
            .frame(width: 300, height: 300)
            
        }
        .ignoresSafeArea()
    }
    
    var vScroll: some View {
        
        ZStack {
            
            Color
                .black
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    ForEach(0..<10) {
                        
                        Text("Item \($0)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(Color.red)
                        
                    }
                    
                }
                
            }
            .frame(height: 350)
            
        }
        .ignoresSafeArea()
        
    }
    
    var hScroll: some View {
        
        ZStack {
            
            Color
                .black
                .ignoresSafeArea()
            
            ScrollView(.horizontal) {
                
                HStack(spacing: 20) {
                    
                    ForEach(0..<10) {
                        
                        Text("Item \($0)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(Color.red)
                        
                    }
                    
                }
                
            }
            .frame(height: 350)
            
        }
        .ignoresSafeArea()
        
    }
}

struct ScrollExample_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewExample()
    }
}
