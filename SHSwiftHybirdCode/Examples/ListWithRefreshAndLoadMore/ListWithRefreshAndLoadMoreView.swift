//
//  ListWithRefreshAndLoadMoreView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import SwiftUI

struct ListWithRefreshAndLoadMoreDelegate {
    
    var onReload: () -> Void
    var onLoadMore: () -> Void
}

struct ListWithRefreshAndLoadMoreView: View {
    
    @ObservedObject
    var viewModel: ListWithRefreshAndLoadMoreViewModel
    
    var delegate: ListWithRefreshAndLoadMoreDelegate
    
    var body: some View {
        
        ZStack {
            
            Color
                .white
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            VStack {
             
                Spacer()
                    .frame(height: 60)
                
                ListView(
                    list: viewModel.list,
                    onReload: delegate.onReload,
                    onLoadMore: delegate.onLoadMore
                )
                
            }
            
            
            if viewModel.loading {
                CustomProgressView()
            }
            
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            
            delegate.onReload()
        }
    }
    
}

private struct ListView: View {
    
    var list: [TestItemModel]
    
    var onReload: () -> Void
    var onLoadMore: () -> Void
    
    var body: some View {
        
        List(list) { item in
            
            ListItemView(item: item)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .onAppear {
                    ILog.debug(tag: #file, content: "item \(item.index) \(item.id)")
                    
                    if item.index == list.count - 1 {
                        onLoadMore()
                    }
                }
            
        }
        .listStyle(.plain)
        .refreshable {
            onReload()
        }
    }
}

private struct ListItemView: View {
    
    var item: TestItemModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {

            Spacer()
                .frame(height: 16)

            Text(item.title)

            Spacer()
                .frame(height: 4)

            Text(item.content)

            Spacer()
                .frame(height: 16)
            
            Divider()
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 16)
        
    }
}

struct ListWithRefreshAndLoadMoreView_Previews: PreviewProvider {
    static var previews: some View {
        ListWithRefreshAndLoadMoreView(
            viewModel: ListWithRefreshAndLoadMoreViewModel(),
            delegate: ListWithRefreshAndLoadMoreDelegate(
                onReload: {
                    
                },
                onLoadMore: {
                    
                }
            )
        )
    }
}
