//
//  RestaurantListView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/21.
//

import SwiftUI

struct RestaurantListView: View {
    
    let restaurantModelList: [RestaurantModel]
    
    var body: some View {
       
        ListView(restaurantModelList: restaurantModelList)
        
    }
}

private struct ListView: View {
    
    let restaurantModelList: [RestaurantModel]
    
    var body: some View {
        
        List {
            
            
            ForEach(restaurantModelList.indices, id: \.self) { index in
                
                ListItemView(restaurantModel: restaurantModelList[index])
                    .listRowSeparator(.hidden) // MARK: 去掉分割线iOS 15
            }
           
            
        }
        .listStyle(.plain)
//        .listStyle(SidebarListStyle()) // MARK: 去掉分割线iOS 14
        
        
    }
    
}

/// Small list item type
private struct ListItemView: View {
    
    let restaurantModel: RestaurantModel
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 20) {
            
            Image(restaurantModel.image)
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading) {
                
                Text(restaurantModel.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurantModel.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurantModel.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            
        }
        
    }
    
}

/// Simple list item
//private struct ListItemView: View {
//
//    let restaurantModel: RestaurantModel
//
//    var body: some View {
//
//        HStack {
//
//            Image(restaurantModel.image)
//                .resizable()
//                .frame(width: 40, height: 40)
//
//            Text(restaurantModel.name)
//        }
//
//    }
//
//}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        
        RestaurantListView(restaurantModelList: dummyData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
        
        RestaurantListView(restaurantModelList: dummyData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
        
        RestaurantListView(restaurantModelList: dummyData())
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewDisplayName("iPad Air (5th generation)")
    }
}
