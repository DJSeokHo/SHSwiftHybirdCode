//
//  NaverMapManager.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/27.
//

import Foundation
import NMapsMap

/**
 cocoapod 설치
 sudo gem install cocoapods

 homebrew 설치
 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

 git-lfs 설치
 brew install git-lfs
 
 cocoapod 초기화
 pod init

 git-lfs 초기화
 git-lfs install

 Podfile을 열고 아래 코드 추가
 pod 'NMapsMap'
 
 info.plist
 <key>NMFClientId</key>
 <string>your id here</string>
 
 NMFAuthManager.shared().clientId = "YOUR_CLIENT_ID_HERE" in appdelegate
 */
class NaverMapManager: NSObject, NMFMapViewCameraDelegate {
    
    public static let CLIENT_ID = "lsw4h15akx"
    public static let CLIENT_SECRET = "z5Y8jsygdQbacKFw13cCvHJa01XturW0mloemx4f"
    
    public static let instance = NaverMapManager()
    private override init() {}
  
    public func initInAppDelegate() {
        NMFAuthManager.shared().clientId = NaverMapManager.CLIENT_ID
    }
    
    public func setup(naverMapView: NMFNaverMapView) {
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.logoInteractionEnabled = false
        naverMapView.showCompass = false
        naverMapView.showScaleBar = false
        naverMapView.showZoomControls = false
        naverMapView.showLocationButton = false
    }

    public func smallMode(naverMapView: NMFNaverMapView) {
        naverMapView.mapView.isIndoorMapEnabled = false
        naverMapView.showIndoorLevelPicker = false
        naverMapView.mapView.logoInteractionEnabled = false
        naverMapView.showCompass = false
        naverMapView.showScaleBar = false
        naverMapView.showZoomControls = false
        naverMapView.showLocationButton = false
    }
    

    public func disable(naverMapView: NMFNaverMapView) {
        naverMapView.mapView.allowsRotating = false
        naverMapView.mapView.allowsZooming = false
        naverMapView.mapView.allowsScrolling = false
    }

    public func moveCamera(naverMapView: NMFNaverMapView, lat: Double = 0.0, lng: Double = 0.0) {

        guard lat != 0.0 && lng != 0.0 else {
            return
        }
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        naverMapView.mapView.moveCamera(cameraUpdate)
    }
    
    public func selfLocation(naverMapView: NMFNaverMapView, lat: Double = 0.0, lng: Double = 0.0) {
        
        guard lat != 0.0 && lng != 0.0 else {
            return
        }
        
        let locationOverlay = naverMapView.mapView.locationOverlay
        
        locationOverlay.hidden = false
        locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
        locationOverlay.circleRadius = 50
    }
    
    public func setLayout(
        naverMapView: NMFNaverMapView,
        traffic: Bool,
        building: Bool,
        transit: Bool,
        bicycle: Bool,
        mountain: Bool,
        cadastral: Bool
    ) {
        
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_TRAFFIC, isEnabled: traffic)
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: building)
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: transit)
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_BICYCLE, isEnabled: bicycle)
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_MOUNTAIN, isEnabled: mountain)
        naverMapView.mapView.setLayerGroup(NMF_LAYER_GROUP_CADASTRAL, isEnabled: cadastral)
        
    }
//    public func addMapMovementListener(naverMapView: NMFNaverMapView, mapMovementDelegate: ((_ lat: Double, _ lng: Double) -> Void)?) {
//        naverMapView.mapView.addCameraDelegate(delegate: self)
//        self.mapMovementDelegate = mapMovementDelegate
//    }
//
//    public func removeMapMovementListener(naverMapView: NMFNaverMapView) {
//        naverMapView.mapView.removeCameraDelegate(delegate: self)
//        self.mapMovementDelegate = nil
//    }
//
//    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
//        let cameraPosition = mapView.cameraPosition
//        mapMovementDelegate?(cameraPosition.target.lat, cameraPosition.target.lng)
//        centerMarker?.position = cameraPosition.target
//    }
//
//    public func createCenterMark(naverMapView: NMFNaverMapView, image: UIImage, infoWindowText: String = "", lat: Double = 0.0, lng: Double = 0.0) {
//
//        centerMarker?.mapView = nil
//        centerMarker = nil
//
//        let position = lat == 0.0 && lng == 0.0 ? defaultLatLng : NMGLatLng(lat: lat, lng: lng)
//        let zoomLevel = lat == 0.0 && lng == 0.0 ? 14.0 : 18.5
//
//        naverMapView.mapView.zoomLevel = zoomLevel
//
//        centerMarker = NMFMarker(position: position)
//
//        centerMarker?.width = 34
//        centerMarker?.height = 34
//        centerMarker?.iconImage = NMFOverlayImage(image: image)
//
//        centerMarker?.mapView = naverMapView.mapView
//
//        if centerMarker != nil {
//            if infoWindowText != "" {
//                let infoWindow = NMFInfoWindow()
//                infoWindow.alpha = 0.5
//                let dataSource = NMFInfoWindowDefaultTextSource.data()
//                dataSource.title = infoWindowText
//                infoWindow.dataSource = dataSource
//                infoWindow.open(with: centerMarker!)
//            }
//        }
//
//        let cameraUpdate = NMFCameraUpdate(scrollTo: position)
//        naverMapView.mapView.moveCamera(cameraUpdate)
//    }
//
//    public func createMyLocationMark(naverMapView: NMFNaverMapView, image: UIImage, infoWindowText: String = "현재위치", lat: Double = 0.0, lng: Double = 0.0) {
//
//        myLocationMarker?.mapView = nil
//        myLocationMarker = nil
//
//        let position = lat == 0.0 && lng == 0.0 ? defaultLatLng : NMGLatLng(lat: lat, lng: lng)
//        let zoomLevel = lat == 0.0 && lng == 0.0 ? 14.0 : 18.5
//
//        naverMapView.mapView.zoomLevel = zoomLevel
//
//        myLocationMarker = NMFMarker(position: position)
//
//        myLocationMarker?.width = 44
//        myLocationMarker?.height = 54.5
//        myLocationMarker?.iconImage = NMFOverlayImage(image: image)
//
//        myLocationMarker?.mapView = naverMapView.mapView
//
//        if myLocationMarker != nil {
//            if infoWindowText != "" {
//                let infoWindow = NMFInfoWindow()
//                infoWindow.alpha = 0.7
//                let dataSource = NMFInfoWindowDefaultTextSource.data()
//                dataSource.title = infoWindowText
//                infoWindow.dataSource = dataSource
//                infoWindow.open(with: myLocationMarker!)
//            }
//        }
//
//        let cameraUpdate = NMFCameraUpdate(scrollTo: position)
//        naverMapView.mapView.moveCamera(cameraUpdate)
//    }
//
    
//
//    public func addMark(naverMapView: NMFNaverMapView, icon: UIImage, lat: Double, lng: Double, captionText: String = "", touchHandler: @escaping (_ index: Int) -> Void) {
//
//        let mark = NMFMarker(position: NMGLatLng(lat: lat, lng: lng))
//
//        if captionText != "" {
//            mark.captionText = captionText
//        }
//
//        mark.width = 34
//        mark.height = 34
//        mark.iconImage =  NMFOverlayImage(image: icon)
//
//        mark.mapView = naverMapView.mapView
//
//        markList.append(mark)
//        mark.tag = UInt(markList.count - 1)
//
//        mark.touchHandler = { (overlay: NMFOverlay) -> Bool in
//            touchHandler(Int(mark.tag))
//            return true
//        }
//
//    }
//
//    public func cleanMark() {
//        for mark in markList {
//            mark.touchHandler = nil
//            mark.mapView = nil
//        }
//
//        markList.removeAll()
//    }
//
//    public func cleanCenter() {
//        centerMarker?.mapView = nil
//    }
}
