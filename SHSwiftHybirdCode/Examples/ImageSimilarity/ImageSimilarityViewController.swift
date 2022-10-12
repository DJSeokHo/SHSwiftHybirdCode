//
//  ImageSimilarityViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import UIKit
import SwiftUI
import Vision

class ImageSimilarityViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: ImageSimilarityViewController())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ImageSimilarityView()
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

private struct ImageSimilarityView: View {
    
    private var sourceImage = "is_original"
    
    @State
    private var modelDatas = [
        ModelData(id: 0, imageName: "is_1"),
        ModelData(id: 1, imageName: "is_2"),
        ModelData(id: 2, imageName: "is_3"),
        ModelData(id: 3, imageName: "is_4"),
        ModelData(id: 4, imageName: "is_5"),
        ModelData(id: 5, imageName: "is_6"),
        ModelData(id: 6, imageName: "is_7"),
        ModelData(id: 7, imageName: "is_8"),
        ModelData(id: 8, imageName: "is_9"),
        ModelData(id: 9, imageName: "is_original")
    ]
    
    var body: some View {
        
        ZStack {
            
            Color
                .white
                .ignoresSafeArea()
            
            VStack {
                
                Image(sourceImage)
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fit)
                
                List {
                    
                    ForEach(modelDatas, id: \.id) { model in
                        
                        VStack {
                            
                            Image(model.imageName)
                                .resizable()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .aspectRatio(contentMode: .fit)
                            
                            Text(model.distance)
                                .padding(10)
                        }
                        
                    }
                }
                .listStyle(.plain)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.leading)
        .edgesIgnoringSafeArea(.trailing)
        .task {
            
            self.processImages()
            
        }
        
    }
    
    private func compareImages(imageSource: UIImage, imageTarget: UIImage) -> Float {
        
        var distance = Float(100)
        
        if let sourceObservation = featureprintObservationForImage(image: imageSource) {
            
            if let targetObservation = featureprintObservationForImage(image: imageTarget) {
                
                do{
                   
                    try sourceObservation.computeDistance(&distance, to: targetObservation)
                    
                }
                catch {
                    ILog.debug(tag: #file, content: error.localizedDescription)
                }
                
            }
            
        }
        
        return 100 - distance
    }
    
    private func processImages() {
        
        guard self.modelDatas.count > 0 else{
            return
        }
        
        for index in 0..<modelDatas.count {
            
            modelDatas[index].distance = String(
                compareImages(
                    imageSource: UIImage(named: sourceImage)!,
                    imageTarget: UIImage(named: modelDatas[index].imageName)!
                )
            )
            
        }
        
    }
    
    private func featureprintObservationForImage(image: UIImage) -> VNFeaturePrintObservation? {
        
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        
        do {
            try requestHandler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        }
        catch {
            print("Vision error: \(error)")
            return nil
        }
    }
}

struct ModelData : Identifiable{
    
    public let id: Int
    public var imageName : String
    public var distance : String = "NA"
}

struct ImageSimilarityView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSimilarityView()
    }
}
