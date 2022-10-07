//
//  BottomNavigationExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/30.
//

import UIKit
import SwiftUI

class BottomNavigationExampleViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: BottomNavigationExampleViewController())
    }
    
    private let subContentHomeViewController = SubContentHomeViewController()
    private let subContentFavoriteViewController = SubContentFavoriteViewController()
    private let subContentProfileViewController = SubContentProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ContentView(
                subContentHomeViewController: subContentHomeViewController,
                subContentFavoriteViewController: subContentFavoriteViewController,
                subContentProfileViewController: subContentProfileViewController
            )
        ))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private struct ContentView: View {
    
    var subContentHomeViewController: SubContentHomeViewController
    var subContentFavoriteViewController: SubContentFavoriteViewController
    var subContentProfileViewController: SubContentProfileViewController
    
    @State
    private var seletedTab: Int = 0
    
    private let subContentFavoriteViewModel = SubContentFavoriteViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color
                .gray
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ContainerView(
                    seletedTab: $seletedTab,
                    subContentHomeViewController: subContentHomeViewController,
                    subContentFavoriteViewController: subContentFavoriteViewController,
                    subContentProfileViewController: subContentProfileViewController,
                    subContentFavoriteViewModel: subContentFavoriteViewModel
                )
                
                BottomNavigationView(
                    seletedTab: $seletedTab,
                    onHome: {
//                        ILog.debug(tag: #file, content: "home ??? \(subContentHomeViewController.hashValue)")
                        seletedTab = 0
                    },
                    onFavorite: {
                        ILog.debug(tag: #file, content: "favorite ??? \(subContentFavoriteViewController.hashValue)")
                        seletedTab = 1
                    },
                    onProfile: {
//                        ILog.debug(tag: #file, content: "profile ??? \(subContentProfileViewController.hashValue)")
                        seletedTab = 2
                    })
                
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

private struct ContainerView: View {
    
    @Binding
    var seletedTab: Int
    
    var subContentHomeViewController: SubContentHomeViewController
    var subContentFavoriteViewController: SubContentFavoriteViewController
    var subContentProfileViewController: SubContentProfileViewController
    
    var subContentFavoriteViewModel: SubContentFavoriteViewModel
    
    var body: some View {
        
        switch seletedTab {
     
        case 1:
        
            SubContentFavoriteViewControllerSwiftUI(
                subContentFavoriteViewController: subContentFavoriteViewController,
                viewModel: subContentFavoriteViewModel
            )
            
        case 2:
            
            BottomNavigationViewControllerSwiftUI(viewController: subContentProfileViewController)
            
        default:
            
            BottomNavigationViewControllerSwiftUI(viewController: subContentHomeViewController)
            
        }
    }
}

private struct BottomNavigationView: View {
    
    @Binding
    var seletedTab: Int
    
    var onHome: () -> Void
    var onFavorite: () -> Void
    var onProfile: () -> Void
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                
                onHome()
                
            }, label: {

                VStack(alignment: .center) {

                    switch seletedTab {
                        
                        case 0:
                            
                            Image(systemName: "house.fill")
                                .resizable()
                                .frame(width: 22, height: 22, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                            
                        default:
                            
                            Image(systemName: "house")
                                .resizable()
                                .frame(width: 22, height: 22, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        
                    }
                    

                    Text("Home")
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            })
            .frame(maxWidth:.infinity, maxHeight: DeviceUtility.isNotchScreen() ? 94 : 74)

            
            Button(action: {
            
                onFavorite()
                
            }, label: {

                VStack(alignment: .center) {

                    switch seletedTab {
                        
                        case 1:
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 22, height: 22, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                            
                        default:
                            
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 22, height: 22, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        
                    }
                   
                    Text("Favorite")
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            })
            .frame(maxWidth:.infinity, maxHeight: DeviceUtility.isNotchScreen() ? 94 : 74)

            
            Button(action: {

                onProfile()
                
            }, label: {

                VStack(alignment: .center) {

                    switch seletedTab {
                        
                        case 2:
                            
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 22, height: 22, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                            
                        default:
                            
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 22, height: 22, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                    }
                    
                    Text("Profile")
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            })
            .frame(maxWidth:.infinity, maxHeight: DeviceUtility.isNotchScreen() ? 94 : 74)
            
        }
        .frame(maxWidth: .infinity, maxHeight: DeviceUtility.isNotchScreen() ? 94 : 74)
        .background(.white)
    }
}


struct BottomNavigationViewControllerSwiftUI: UIViewControllerRepresentable {
    
    var viewController: UIViewController
    
    func makeCoordinator() -> Coordinator {
//        ILog.debug(tag: #file, content: "makeCoordinator")
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
//        ILog.debug(tag: #file, content: "makeUIViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        ILog.debug(tag: #file, content: "updateUIViewController")
    }
    
    static func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: ()) {
//        ILog.debug(tag: #file, content: "dismantleUIViewController")
    }
    
}
