//
//  NaverMapView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/27.
//

import SwiftUI
import NMapsMap

struct NaverMapViewDelegate {
    
    var onFinish: () -> Void
    var onInit: (_ naverMapView: NMFNaverMapView) -> Void
    var onCheckPermission: () -> Void
}

struct NaverMapView: View {
    
    var delegate: NaverMapViewDelegate
    
    var body: some View {
        ContentView(delegate: delegate)
    }
}

private struct ContentView: View {
    
    var delegate: NaverMapViewDelegate
    var naverMapView = NMFNaverMapView()
    
    @State
    private var actionMenu = false
    
    @State
    private var toggleAll = false
    
    @State
    private var traffic = false
    @State
    private var building = false
    @State
    private var transit = false
    @State
    private var bicycle = false
    @State
    private var mountain = false
    @State
    private var cadastral = false
    
    var body: some View {
        
        ZStack {
            
            NaverMapUIViewRepresentable(
                naverMapView: naverMapView,
                traffic: $traffic,
                building: $building,
                transit: $transit,
                bicycle: $bicycle,
                mountain: $mountain,
                cadastral: $cadastral
            )
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        actionMenu.toggle()
                        
                    }, label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .background(.white)
                            .clipShape(Circle())
                            .padding()
                    })
                    .padding()
                }
               
            }
            
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            delegate.onInit(naverMapView)
        }
        .sheet(isPresented: $actionMenu, content: {
            
            VStack {
                
                Toggle(isOn: $toggleAll, label: {})
                    .labelsHidden()
                    .onChange(of: toggleAll, perform: { value in
                        
                        ILog.debug(tag: #file, content: "toggleAll \(value)")
                        
                        traffic = value
                        building = value
                        transit = value
                        bicycle = value
                        mountain = value
                        cadastral = value
                        
                        actionMenu.toggle()
                    })
            }
            
        })
        
    }
}

struct NaverMapView_Previews: PreviewProvider {
    
    static var previews: some View {
        NaverMapView(
            delegate: NaverMapViewDelegate(
                onFinish: {
                    
                },
                onInit: { naverMapView in
                    
                    
                },
                onCheckPermission: {
                    
                }
            )
        )
    }
}



private struct NaverMapUIViewRepresentable: UIViewRepresentable {
    
    var naverMapView: NMFNaverMapView
    
    @Binding
    var traffic: Bool
    @Binding
    var building: Bool
    @Binding
    var transit: Bool
    @Binding
    var bicycle: Bool
    @Binding
    var mountain: Bool
    @Binding
    var cadastral: Bool
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        naverMapView.frame = view.frame
        view.addSubview(naverMapView)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        ILog.debug(tag: #file, content: "updateUIView traffic \(traffic)")
        
        NaverMapManager.instance.setLayout(
            naverMapView: naverMapView,
            traffic: traffic,
            building: building,
            transit: transit,
            bicycle: bicycle,
            mountain: mountain,
            cadastral: cadastral
        )
    }
}
