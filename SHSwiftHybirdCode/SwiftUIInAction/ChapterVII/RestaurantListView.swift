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
                
            }
           
            
        }
        .listStyle(.plain)
        
    }
    
}

private struct ListItemView: View {
    
    let restaurantModel: RestaurantModel
    
    var body: some View {
        
        HStack {
            
            Image(restaurantModel.image)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(restaurantModel.name)
        }
        
    }
    
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        
        RestaurantListView(restaurantModelList: dummyData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
        
        RestaurantListView(restaurantModelList: dummyData())
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewDisplayName("iPad Air (5th generation)")
    }
}
