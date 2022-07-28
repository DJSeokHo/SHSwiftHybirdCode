//
//  RestaurantListView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/21.
//

import SwiftUI

struct RestaurantListDelegate {
    
    var onItemClick: (_ restaurantModel: RestaurantModel) -> Void
    
}

struct RestaurantListView: View {
   
    @State
    var restaurantModelList: [RestaurantModel]
    
    var delegate: RestaurantListDelegate
    
    var body: some View {
       
        ListView(
            restaurantModelList: $restaurantModelList,
            onItemClick: { restaurantModel in
            
                delegate.onItemClick(restaurantModel)
                
            }
        )
        
    }
}

private struct ListView: View {
    
    @Binding
    var restaurantModelList: [RestaurantModel]
    
    var onItemClick: (_ restaurantModel: RestaurantModel) -> Void
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(restaurantModelList.indices, id: \.self) { index in
                    
                    ListItemView(
                        restaurantModel: $restaurantModelList[index],
                        onItemClick: onItemClick
                    )
                    .listRowSeparator(.hidden) // MARK: 去掉分割线iOS 15
                }
                .onDelete(perform: { indexSet in
                    
                    restaurantModelList.remove(atOffsets: indexSet)
                    
                })
                
            }
            .listStyle(.plain)
    //        .listStyle(SidebarListStyle()) // MARK: 去掉分割线iOS 14
            .navigationTitle("FoodPin")
            .navigationBarTitleDisplayMode(.automatic)
        }
       
    }
}

/// Small list item type
private struct ListItemView: View {

    @Binding
    var restaurantModel: RestaurantModel
    
    var onItemClick: (_ restaurantModel: RestaurantModel) -> Void
//    @State
//    private var showOptions = false
    
    @State
    private var showSheets = false
    
    @State
    private var showError = false
    
    @State
    private var tapState = false

    var body: some View {
        
        VStack {
            
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
                
                if restaurantModel.isFavorite {
                    Spacer()

                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }

            }
            .contextMenu(menuItems: {
                
                Button(action: {
                    
                    self.showError.toggle()
                    
                }, label: {
                    
                    HStack {
                        
                        Text("Reserve a table")
                        Image(systemName: "phone")
                        
                    }
                    
                })
                
                Button(action: {
                    
                    self.restaurantModel.isFavorite.toggle()
                    
                }, label: {
                    
                    HStack {
                        
                        Text(restaurantModel.isFavorite ? "Remove from favorites" : "Mark as favorite")
                        Image(systemName: "heart")
                    }
                    
                })
                
                Button(action: {
                    self.showSheets.toggle()
                }) {
                    HStack {
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            })
    //        .onTapGesture {
    ////            showOptions.toggle()
    //        }
            .sheet(isPresented: $showSheets) {

                let defaultText = "Just checking in at \(restaurantModel.name)"

                if let imageToShare = UIImage(named: restaurantModel.image) {
                    ActivityView(activityItems: [defaultText, imageToShare])
                }
                else {
                    ActivityView(activityItems: [defaultText])
                }
            }
    //        .actionSheet(isPresented: $showOptions) {
    //            ActionSheet(
    //                title: Text("What do you want to do?"),
    //                message: nil, buttons: [
    //                    .default(Text("Reserve a table"), action: {
    //                        self.showError.toggle()
    //                    }),
    //                    .default(Text("Mark as favorite"), action: {
    //                        self.restaurantModel.isFavorite.toggle()
    //                    }),
    //                    .cancel({
    //
    //                    })
    //                ]
    //            )
    //        }
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Not yet available"),
                    message: Text("Sorry, this feature is not available yet. Please retry later."),
                    dismissButton: .cancel(Text("OK"))
                )
            }
            
        }
        .onTapGesture {
            
            tapState = true
            
            onItemClick(restaurantModel)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tapState = false
                
            }
        }
        .background(tapState ? Color("ColorEEEEEE") : .clear)
    }
}

/// Big list item type
//private struct ListItemView: View {
//
//    let restaurantModel: RestaurantModel
//
//    var body: some View {
//
//        VStack(alignment: .leading, spacing: 10) {
//
//            Image(restaurantModel.image)
//                .resizable()
//                .scaledToFill()
//                .frame(height: 200)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//
//            VStack(alignment: .leading) {
//
//                Text(restaurantModel.name)
//                    .font(.system(.title2, design: .rounded))
//
//                Text(restaurantModel.type)
//                    .font(.system(.body, design: .rounded))
//
//                Text(restaurantModel.location)
//                    .font(.system(.subheadline, design: .rounded))
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}

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
//}

struct RestaurantListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        RestaurantListView(restaurantModelList: dummyData(), delegate: RestaurantListDelegate(onItemClick: { model in }))
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
        .previewDisplayName("iPhone 13 Pro Max")
        
        RestaurantListView(restaurantModelList: dummyData(), delegate: RestaurantListDelegate(onItemClick: { model in }))
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
        .previewDisplayName("iPhone 13 Pro Max")
        .preferredColorScheme(.dark)
        
        RestaurantListView(restaurantModelList: dummyData(), delegate: RestaurantListDelegate(onItemClick: { model in }))
        .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
        .previewDisplayName("iPad Air (5th generation)")
    }
}
