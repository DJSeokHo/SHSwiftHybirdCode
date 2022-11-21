//
//  CustomProgressView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import SwiftUI

struct CustomProgressView: View {
    
    var body: some View {
       
        ZStack {
            
            Color
                .clear
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                    // MARK: use contentShape to handle te tap event
                    
                }
            
            ProgressView()
                .progressViewStyle(.circular)
                .tint(Color.white)
                .frame(width: 50, height: 50, alignment: .center)
                .background(.black.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaleEffect(1.5)
        }
        
    }
    
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
