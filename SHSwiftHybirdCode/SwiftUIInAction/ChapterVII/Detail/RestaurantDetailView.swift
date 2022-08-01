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
    
    @State
    private var ratingState: Rating? = nil
    
    @State
    private var showReviewState = false
    
    var body: some View {
    
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    ImageView(
                        image: restaurantModel.image,
                        name: restaurantModel.name,
                        type: restaurantModel.type,
                        ratingState: $ratingState,
                        showReviewState: $showReviewState
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
                    
                    ReviewButtonView(
                        onReview: {
                            
                            withAnimation(.easeIn(duration: 0.3)) {
                                showReviewState = true
                            }
                           
                        }
                    )
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
            .overlay(
                self.showReviewState ?
                
                    ZStack {
                        ReviewView(delegate: ReviewDelegate(
                            onCloseClick: { rating in
                                
                                self.restaurantModel.rating = rating
                                
                                self.ratingState = rating
                                // MARK: SwiftUI 中要以動畫呈現狀態的變更只需要將狀態的變更包裹進去 withAnimation 程式塊中， withAnimation  帶入一個動畫參數。這裏我們指定使用 .easeOut 動畫，動畫時間設定為 0.3 秒。 SwiftUI  內建數種動畫，.easeOut 只是其中一項。
                                withAnimation(.easeOut(duration: 0.3)) {
                                    self.showReviewState = false
                                }
                                
                            }
                        ), image: restaurantModel.image)
                        .navigationBarHidden(true)
                    }
                
                : nil
            )
        }
        .onAppear(perform: {
            ratingState = restaurantModel.rating
        })
        
    }
}


private struct ImageView: View {
    
    var image: String
    var name: String
    var type: String
    
    @Binding
    var ratingState: Rating?
    
    @Binding
    var showReviewState: Bool
    
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
            
            if let rating = ratingState, !showReviewState {
                
                ZStack {
                    Image(rating.image)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 60, height: 60, alignment: .bottomTrailing)
                        .transition(.scale)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
            }
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

private struct ReviewButtonView: View {
    
    var onReview: () -> Void
    
    var body: some View {
        
        Button(action: {
            
            onReview()
            
        }, label: {
            
            Text("Rate it")
                .font(.system(.headline, design: .rounded))
                .frame(minWidth: 0, maxWidth: .infinity)
            
        })
        .tint(Color("NavigationBarTitle"))
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 25))
        .controlSize(.large)
        .padding(.horizontal)
        .padding(.bottom, 30)
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
