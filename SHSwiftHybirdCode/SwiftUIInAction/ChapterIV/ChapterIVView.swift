//
//  ChapterIVView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import SwiftUI

struct ChapterIVDelegate {
    
    var onFinish: () -> Void
    
}

struct ChapterIVView: View {
    
    var delegate: ChapterIVDelegate
    
    var body: some View {
       
        tutorial
        
    }
    
    var tutorial: some View {
        
        ZStack(alignment: .top, content: {
          
            Color.white
            
            VStack {
                
                Spacer()
                    .frame(height: 50)
                
                TopAppBarView(
                    trailingImageName: "xmark",
                    onTrailingClick: {
                        delegate.onFinish()
                    }
                )
                
                Text("Instant Developer")
                    .fontWeight(.medium)
                    .font(.system(size: 40))
                    .foregroundColor(.purple)
                
                Text("Coding with cat")
                
            }
            
        })
        .ignoresSafeArea()
    }
}

struct ChapterIVView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterIVView(
            delegate: ChapterIVDelegate(
                onFinish: {
                   
                }
            )
        )
    }
}
