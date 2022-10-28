//
//  DrawerMenuExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/28.
//

import SwiftUI

struct DrawerMenuExampleView: View {
    
    var body: some View {
        
        ContentView()
        
    }
}

private struct ContentView: View {
    
    @State
    private var showMenu = false
 
    var body: some View {
        
        ZStack {
         
            Color
                .white
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.showMenu.toggle()
                        
                    }, label: {
                        Image(systemName: "text.justify")
                            .font(.title)
                            .foregroundColor(.black)
                    })
                    .padding()
                }
                
                Spacer()
                
                Text("ContentView")
                    .padding()
                    .font(.title)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack {
                
                Spacer()
                
                Color
                    .white
                    .opacity(0.000001)
                    .frame(width: 50)
                    .padding(.top, 50)
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded(
                                { value in
                                    if value.translation.width < 0 {
                                        // left
                                        ILog.debug(tag: "???", content: "left")
                                        showMenu.toggle()
                                    }

                                    if value.translation.width > 0 {
                                        // right
                                        ILog.debug(tag: "???", content: "right")
                                    }
                                    if value.translation.height < 0 {
                                        // up
                                        ILog.debug(tag: "???", content: "up")
                                    }

                                    if value.translation.height > 0 {
                                        // down
                                        ILog.debug(tag: "???", content: "down")
                                    }
                                }
                            )
                    )
            }
          
            
            Color
                .black
                .ignoresSafeArea(.all, edges: .all)
                .opacity(showMenu ? 0.7 : 0)
                .animation(.easeOut(duration: 0.2), value: showMenu)
                .onTapGesture {
                    showMenu.toggle()
                }
            
            // GeometryReader的主要作用就是能够获取到父view建议的尺寸
            GeometryReader(content: { _ in
                
                HStack {
                    
                    DrawerMenuView()
                        .offset(x: showMenu ? UIScreen.main.bounds.width - 200 : UIScreen.main.bounds.width)
                        .animation(.easeOut(duration: 0.2), value: showMenu) // 0.5 sec
//                        .offset(x: UIScreen.main.bounds.width - 200)
//                        .offset(x: UIScreen.main.bounds.width) // 0的话，菜单的左上角和手机左上角重合，所以要偏移到画面宽度，这样的话菜单就在画面的右侧外面，不可见。
                    
                }
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded(
                            { value in
                                if value.translation.width < 0 {
                                    // left
                                    ILog.debug(tag: "???", content: "left")
                                }

                                if value.translation.width > 0 {
                                    // right
                                    ILog.debug(tag: "???", content: "right")
                                    showMenu.toggle()
                                }
                                if value.translation.height < 0 {
                                    // up
                                    ILog.debug(tag: "???", content: "up")
                                }

                                if value.translation.height > 0 {
                                    // down
                                    ILog.debug(tag: "???", content: "down")
                                }
                            }
                        )
                )
            })
            
        }
       
    }
}

private struct DrawerMenuView: View {
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Text("Settings")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .frame(width: 200)
        .background(.gray)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct DrawerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerMenuExampleView()
    }
}
