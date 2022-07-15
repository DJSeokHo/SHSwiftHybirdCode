//
//  TopAppBarView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import SwiftUI

struct TopAppBarView: View {
    
    var leadingImageName: String = ""
    var loadingColor: String = "#000000"
    
    var title: String = ""
    var titleColor: String = "#000000"
    
    var trailingImageName: String = ""
    var trailingColor: String = "#000000"
    
    var backgroundColor: String = "#FFFFFF"
    
    var onLeadingClick: (() -> Void)? = nil
    var onTrailingClick: (() -> Void)? = nil
    
    var body: some View {
       
        HStack(alignment: .center, content: {
            
            if leadingImageName != "" {
                
                Button(action: {
                    onLeadingClick?()
                }, label: {
                    
                    Image(systemName: leadingImageName)
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.leading, 16)
                        .foregroundColor(Color(hex: loadingColor))
                })
                
            }
            
            Spacer()
            
            if title != "" {
                
                Text(title)
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(Color(hex: titleColor))
                    .padding(.horizontal, 10)
            }
            
            
            Spacer()
            
            if trailingImageName != "" {
                
                Button(action: {
                    onTrailingClick?()
                }, label: {
                    
                    Image(systemName: trailingImageName)
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing, 16)
                        .foregroundColor(Color(hex: trailingColor))
                })
            }
        })
        .frame(height: 50)
    }
}

struct TopAppBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopAppBarView()
    }
}
