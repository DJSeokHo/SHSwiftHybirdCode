//
//  ChapterIVHomeworkView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/16.
//

import SwiftUI

struct ChapterIVHomeworkDelegate {
    
    var onFinish: () -> Void
    
}

struct ChapterIVHomeworkView: View {
    
    var delegate: ChapterIVHomeworkDelegate
    
    @Environment(\.verticalSizeClass)
    var verticalSizeClass
    
    var body: some View {
      
        homework
        
    }
    
    var homework: some View {
        
        ZStack(content: {
          
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
              
                TopAppBarView(
                    trailingImageName: "xmark",
                    trailingColor: "#FFFFFF",
                    onTrailingClick: {
                        delegate.onFinish()
                    }
                )
                
                Spacer()
                    .frame(height: 20)
                
                topLabel
                
                imagesInfo
                
                // MARK: 關鍵在於使用一種 SwiftUI 的特殊元件，元件名稱為留白（spacer），留白視圖是一種沒有內容的視圖，在堆疊視圖內充滿一定的空間。舉例，當你將留白視圖置於垂直佈局中時，它會在堆疊中的垂直方向盡可能的擴展。
                Spacer()
                
                if verticalSizeClass == .compact {
                    horizontalButtons
                }
                else {
                    verticalButtons
                }
                
            }
            .padding(.top, 50)
            .padding(.bottom, 30)
            
        })
        .ignoresSafeArea()
    }
    
    private var topLabel: some View {
        
        VStack {
            
            Text("Instant Developer")
                .fontWeight(.medium)
                .font(.system(size: 40))
                .foregroundColor(.purple)
            
            Text("Coding with cat")
                .foregroundColor(.white)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
        }
    }
    
    private var imagesInfo: some View {
        
        VStack(spacing: 10) {
            
            HStack(alignment: .bottom, spacing: 10, content: {
                
                Image("student")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Image("tutor")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
    
            })
            .padding(.horizontal, 60)
            
            Text("Need help with coding problems? Register!")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 18, design: .rounded))
        }
    }
    
    private var horizontalButtons: some View {
        
        HStack {
            
            Button(action: {
                
            }, label: {
                Text("Sign Up")
                    .fontWeight(.bold)
            })
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.purple)
            .cornerRadius(10)
            
            Button(action: {
                
            }, label: {
                Text("Sign In")
                    .fontWeight(.bold)
            })
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
        }
        
    }
    
    private var verticalButtons: some View {
        
        VStack {
            
            Button(action: {
                
            }, label: {
                Text("Sign Up")
                    .fontWeight(.bold)
            })
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.purple)
            .cornerRadius(10)
            
            Button(action: {
                
            }, label: {
                Text("Sign In")
                    .fontWeight(.bold)
            })
            .frame(width: 200)
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(10)
        }
        
    }
}

struct ChapterIVHomeworkView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterIVHomeworkView(
            delegate: ChapterIVHomeworkDelegate(
                onFinish: {
                   
                }
            )
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
        .previewDisplayName("iPhone 13 Pro Max")
        
        
        if #available(iOS 15.0, *) {
            ChapterIVHomeworkView(
                delegate: ChapterIVHomeworkDelegate(
                    onFinish: {
                        
                    }
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
            .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
