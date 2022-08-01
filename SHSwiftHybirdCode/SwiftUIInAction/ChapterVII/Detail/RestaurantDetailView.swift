//
//  RestaurantDetailView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/27.
//

import SwiftUI

struct RestaurantDetailDelegate {
    
    var onBackClick: () -> Void
    var onMapClick: (_ restaurantModel: RestaurantModel) -> Void
    
}

struct RestaurantDetailView: View {
    
    var restaurantModel: RestaurantModel
    
    var delegate: RestaurantDetailDelegate
    
    var body: some View {
    
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    ImageView(
                        image: restaurantModel.image,
                        name: restaurantModel.name,
                        type: restaurantModel.type
                    )
                    
                    DescriptionView(description: restaurantModel.description)
                    
                    DetailInfoView(
                        location: restaurantModel.location,
                        phone: restaurantModel.phone
                    )
                    
                    MapView(location: restaurantModel.location)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(20)
                        .padding()
                        .onTapGesture {
                            delegate.onMapClick(restaurantModel)
                        }
                }
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(action: {
                        
                        delegate.onBackClick()
                        
                    }, label: {
                        
                        HStack(alignment: .center, spacing: 6) {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                            
                            Text(restaurantModel.name)
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            
                        }
                        
                    })
                    
                }
            }
        }
        
    }
}


private struct ImageView: View {
    
    var image: String
    var name: String
    var type: String
    
    var body: some View {
        
        ZStack {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 445)
            
            ZStack(alignment: .topTrailing) {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .foregroundColor(.white)
                    .padding(.top, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
           
            InfoView(name: name, type: type)
        }
    }
}

private struct InfoView: View {
    
    var name: String
    var type: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            Text(name)
                .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                .bold()
            
            Text(type)
                .font(.system(.headline, design: .rounded))
                .padding(.all, 5)
                .background(Color.black)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity,
               alignment: .bottomLeading)
        .foregroundColor(.white)
        .padding()
        
    }
}

private struct DescriptionView: View {
    
    var description: String
    
    var body: some View {
        
        Text(description)
            .padding()
    }
}

private struct DetailInfoView: View {
    
    var location: String
    var phone: String
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            VStack(alignment: .leading) {
                Text("ADDRESS")
                    .font(.system(.headline, design: .rounded))

                Text(location)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading) {
                Text("PHONE")
                    .font(.system(.headline, design: .rounded))
                
                Text(phone)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
     
        RestaurantDetailView(restaurantModel: RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: false), delegate: RestaurantDetailDelegate(onBackClick: {}, onMapClick: { restaurantModel in }))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
        
        RestaurantDetailView(restaurantModel: RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: false), delegate: RestaurantDetailDelegate(onBackClick: {}, onMapClick: { restaurantModel in }))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
        
        RestaurantDetailView(restaurantModel: RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: false), delegate: RestaurantDetailDelegate(onBackClick: {}, onMapClick: { restaurantModel in }))
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewDisplayName("iPad Air (5th generation)")
    }
}
