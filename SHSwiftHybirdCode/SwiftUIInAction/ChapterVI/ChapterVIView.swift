//
//  ChapterVIView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/16.
//

import SwiftUI

struct ChapterVIDelegate {
    
    var onFinish: () -> Void
    
}

struct ChapterVIView: View {
    
    var delegate: ChapterVIDelegate
    
    var restaurantNames: [String]
    
    var body: some View {
       
        VStack {
            
            TopAppBarView(
                trailingImageName: "xmark",
                trailingColor: "#FFFFFF",
                backgroundColor: "#666666",
                onTrailingClick: {
                    delegate.onFinish()
                }
            )
            
            list
            
        }
        
    }
    
    private var list: some View {
        
        List {
            
            ForEach(0...restaurantNames.count - 1, id: \.self) { index in
                
                HStack {
                    Image(restaurantNames[index])
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text(restaurantNames[index])
                }
            }
            
        }
        .listStyle(.plain)
    }
}

struct ChapterVIView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterVIView(
            delegate: ChapterVIDelegate(
                onFinish: {}
            ),
            restaurantNames: ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
        .previewDisplayName("iPhone 13 Pro Max")
        
        ChapterVIView(
            delegate: ChapterVIDelegate(
                onFinish: {}
            ),
            restaurantNames: ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
        )
        .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
        .previewDisplayName("iPad Air (5th generation)")
    }
}
