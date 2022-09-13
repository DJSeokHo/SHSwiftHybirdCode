//
//  ScrollViewReaderExample.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import SwiftUI

struct ScrollViewReaderExample: View {
    
    let colors: [Color] = [.red, .green, .blue]

    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                Button("Jump to #26") {
                    
                    // value.scrollTo(26, anchor: .top)
                    
                    withAnimation {
                        value.scrollTo(26, anchor: .top)
                    }
                  
                }
                .padding()

                ForEach(0..<100) { i in
                    Text("Example \(i)")
                        .font(.title)
                        .frame(width: 300, height: 200)
                        .background(colors[i % colors.count])
                        .id(i)
                }
            }
        }
        .frame(height: 450)
    }
    
}

struct ScrollViewReaderExample_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderExample()
    }
}
