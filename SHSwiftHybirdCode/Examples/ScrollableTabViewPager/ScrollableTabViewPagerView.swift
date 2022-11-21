//
//  ScrollableTabViewPagerView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import SwiftUI

struct ScrollableTabViewPagerView: View {
    
    let tabs = ["Title 0", "Title 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6", "Title 7"]
    
    @State
    private var index = 0
    
    var body: some View {
       
        ZStack {
            
            Color
                .white
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            VStack {
                
                Spacer()
                    .frame(height: 60)
                
                Divider()
                
                TabLayoutView(index: $index, tabs: tabs)
                
                Divider()
                
                ViewPagerView(index: $index, tabs: tabs)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
          
        }
        .ignoresSafeArea(.all, edges: .all)
        
    }
}

private struct TabLayoutView: View {
    
    @Binding
    var index: Int
    
    var tabs: [String]
    
    var body: some View {
     
        ScrollViewReader { scrollViewProxy in
            
            ScrollView(.horizontal, showsIndicators: false) {

                ZStack {

                    HStack {

                        ForEach(tabs,id:\.self) { item in

                            Text(item)
                                .font(.system(size:15))
                                .padding(15)
                                .foregroundColor(tabs[index] == item ? .black : .gray)
                                .onTapGesture {

                                    ILog.debug(tag: #file, content: item)
                                    withAnimation (.easeInOut) {

                                        index = tabs.firstIndex(of: item) ?? 0

                                    }
                                }
                                .id(item)//这里必须添加id，为了跟随页面滚动tabbar，当然如果需求不需要，可以不加

                        }
                    }
                    .background(
                        GeometryReader { geometryProxy in
                            Color.clear.preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: -geometryProxy.frame(in: .named("scrollX")).origin.x
                            )
                        }
                    )
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        // 滑动距离，这里监听的是 x
                        ILog.debug(tag: #file, content: "scrollX \(value)")
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .onChange(of: index) { newValue in
                
                ILog.debug(tag: #file, content: "onChange \(newValue)")
                
                withAnimation {
//                    scrollViewProxy.scrollTo(tabs[newValue])
                    scrollViewProxy.scrollTo(tabs[newValue], anchor: .center) // 选中项保持滑动剧中
                }
            }
        }
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}


private struct ViewPagerView: View {
    
    @Binding
    var index: Int
    
    var tabs: [String]
    
    var body: some View {
        
        TabView(selection: $index) {
            
            ForEach(tabs.indices, id: \.self) { index in
                
                ViewPagerItemView(tab: tabs[index])
                    .tag(index)
                
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
    }
    
}

private struct ViewPagerItemView: View {
    
    var tab: String
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Text(tab)
                .font(.system(size: 30))
                .foregroundColor(.black)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct ScrollableTabViewPagerView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableTabViewPagerView()
    }
}
