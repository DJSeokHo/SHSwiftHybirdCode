//
//  ChapterXXView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/23.
//

import SwiftUI

struct ChapterXXView: View {
    
    let pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION", "DISCOVER GREAT RESTAURANTS"]
    
    let pageSubHeadings = ["Pin your favorite restaurants and create your own food guide", "Search and locate your favorite restaurant on Maps", "Find restaurants shared by your friends and other foodies"]
    
    let pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]

    @State
    private var currentPage = 0
    
    @Environment(\.dismiss)
    var dismiss
        
    init() {
        // MARK: 修改点点指示器的颜色
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemIndigo
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    var body: some View {
        
        VStack {
            
            /**
             在 TabView，我們使用 TutorialPage 來呈現導覽畫面的每一個頁面。 .tag  修飾器提供每一個頁面唯一的索引值。欲將標準標籤視圖轉換成頁面滾動視圖，你只需要將標籤視圖的樣式設定為  PageTabViewStyle
             */
            TabView(selection: $currentPage) {
                
                ForEach(pageHeadings.indices, id: \.self) { index in
                    
                    ChapterXXItemView(image: pageImages[index], heading: pageHeadings[index], subHeading: pageSubHeadings[index]).tag(index)
                    
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic)) // indexViewStyle 為定義頁面指示器的樣式。看不见指示器是因为默认是白色的，怎么办?
            .animation(.default, value: currentPage)
            
            
            VStack(spacing: 20) {
                
                Button(action: {
                    if currentPage < pageHeadings.count - 1 {
                        currentPage += 1
                    }
                    else {
                        dismiss()
                    }
                }, label: {
                  
                    Text(currentPage == pageHeadings.count - 1 ? "GET STARTED" : "NEXT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color(.systemIndigo))
                        .cornerRadius(25)
                    
                })
                
                if currentPage < pageHeadings.count - 1 {
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(Color(.darkGray))
                    })
                }
            }
            .padding(.bottom)
        }
        
        
    }
}

private struct ChapterXXItemView: View {
    
    let image: String
    let heading: String
    let subHeading: String
    
    var body: some View {
        
        VStack(spacing: 70) {
            
            Image(image)
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 10) {
                
                Text(heading)
                    .font(.headline)
                
                Text(subHeading)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top)
        
    }
}

struct ChapterXXView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterXXItemView(
            image: "onboarding-1",
            heading: "CREATE YOUR OWN FOOD GUIDE",
            subHeading: "Pin your favorite restaurants and create your own food guide"
        ).previewLayout(.sizeThatFits)
        
        ChapterXXView()
    }
}
