//
//  VStackExample.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import SwiftUI

/**
 默认情况下，堆栈中的项目在中心对齐。 对于 HStack，这意味着项目在中间垂直对齐，因此，如果您有两个高度不同的文本视图，则它们都将在其垂直中心对齐。 对于 VStack，这意味着项目在中间居中对齐，因此，如果您有两个不同长度的文本视图，则它们都将与其水平中心对齐。
 
 它们最终仍将位于屏幕的中间，因为堆栈仅占用所需的空间。
 */
struct VStackExample: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            Text("SwiftUI")
            Text("rocks")
        }
    }
}

struct VStackExample_Previews: PreviewProvider {
    static var previews: some View {
        VStackExample()
    }
}
