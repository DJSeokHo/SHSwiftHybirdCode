//
//  SpacerExample.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import SwiftUI

/**
 如何使用 Spacer 将视图强制移到堆栈中的一侧？
 Spacers 会自动划分所有剩余空间，这意味着如果您使用多个垫片，则可以按不同数量划分空间。
 例如，这将通过在其上放置一个空格，在其后放置两个空格，将文本视图放置在其父视图的三分之一以下
 */
struct SpacerExample: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Hello World")
            Spacer()
            Spacer()
        }
    }
}

struct SpacerExample_Previews: PreviewProvider {
    static var previews: some View {
        SpacerExample()
    }
}
