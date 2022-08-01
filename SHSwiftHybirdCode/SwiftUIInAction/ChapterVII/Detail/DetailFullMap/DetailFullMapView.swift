//
//  DetailFullMapView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/01.
//

import SwiftUI


struct DetailFullMapDelegate {
    
    var onBackClick: () -> Void
    
}


struct DetailFullMapView: View {
    
    var delegate: DetailFullMapDelegate
    var name: String
    var location: String
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                MapView(location: location)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
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
                            
                            Text(name)
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

struct DetailFullMapView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFullMapView(delegate: DetailFullMapDelegate(onBackClick: {}), name: "", location: "")
    }
}
