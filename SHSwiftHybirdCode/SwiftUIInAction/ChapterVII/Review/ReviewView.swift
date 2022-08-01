//
//  ReviewView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/01.
//

import SwiftUI

struct ReviewDelegate {
    
    var onCloseClick: (_ rating: Rating?) -> Void
    
}

struct ReviewView: View {
    
    var delegate: ReviewDelegate
    var image: String
    
    @State
    private var showRatings = false
    
    var body: some View {
        
        ZStack {
            
           Image(image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            // MARK: background
            /*
             .ultraThinMaterial
             .thinMaterial
             .regularMaterial
             .thickMaterial
             .ultraThickMaterial
             */
            Color.black
                .opacity(0.6)
                .background(.ultraThinMaterial)
            
            
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Button(action: {

                        delegate.onCloseClick(nil)
                        
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 30.0))
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .padding(.trailing, 30)
                    }

                    Spacer()
              
                }
            }
            
            VStack(alignment: .leading) {
                
                ForEach(Rating.allCases, id: \.self) { rating in

                        HStack {
                            Image(rating.image)
                            Text(rating.rawValue.capitalized)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .opacity(showRatings ? 1.0: 0)
                        .offset(x: showRatings ? 0: 1000)
                        .animation(.easeOut.delay(
                            Double(Rating.allCases.firstIndex(of: rating)!) * 0.05
                        ), value: showRatings)
                        .onTapGesture {
                            
                            delegate.onCloseClick(rating)
                            
                        }
                    }
                }
                       
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            showRatings.toggle()
        })
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(
            delegate: ReviewDelegate(
                onCloseClick: { rating in
                    
                }
            ),
            image: "cafedeadend"
        )
    }
}
