//
//  HStackExample.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import SwiftUI

struct HStackExample: View {
    
    var body: some View {
        // 它们最终仍将位于屏幕的中间，因为堆栈仅占用所需的空间。
        HStack(alignment: .bottom, spacing: 10) {
            Text("SwiftUI")
                .padding(.top, 20)
            
            Text("rocks")
        }
    }
}

struct HStackExample_Previews: PreviewProvider {
    static var previews: some View {
        HStackExample()
    }
}
