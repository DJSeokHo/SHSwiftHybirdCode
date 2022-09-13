//
//  ZStackExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import SwiftUI

struct ZStackExampleView: View {
    var body: some View {
        
        ZStack() {
            
            Color
                .yellow
                .ignoresSafeArea()
            
            Text("Hello, World!")
        }
        .ignoresSafeArea()
    }
}

struct ZStackExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStackExampleView()
    }
}
