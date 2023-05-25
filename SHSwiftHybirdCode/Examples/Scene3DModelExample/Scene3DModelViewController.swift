//
//  Scene3DModelViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/19.
//

import UIKit
import SwiftUI
import SceneKit
import SceneKit.ModelIO
import GLTFSceneKit

class Scene3DModelViewController: UIViewController, URLSessionDelegate {

    private var scene: SCNScene? = nil
    
    private var scnView: SCNView {
        return self.view as! SCNView
    }
    
    override func loadView() {
        self.view = SCNView(frame: .zero)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        setupSceneView()
        setupCamera()
        setupLight()
        
        downloadSceneTask()
        
    }
    
    func downloadSceneTask() {
        
        ILog.debug(tag: #file, content: "downloadSceneTask")
            
        //1. Get The URL Of The SCN File
//        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/77wsgpz2zoalvkt/3d_model_animation_kalug.usdz?dl=0") else { return }
//        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/x6f83d5r8y3mbio/e_10_2_model.glb?dl=0") else { return }
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/g8iiyzxkvpo7nf9/%EC%82%B0%EB%B9%84%EC%84%A0_M.glb?dl=0") else { return }
    
//        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/da286k0jrx3e18y/3d_model_animation_1.glb?dl=0") else { return }
    
        
        //2. Create The Download Session
        let downloadSession = URLSession(configuration: URLSession.shared.configuration, delegate: self, delegateQueue: nil)
        
        //3. Create The Download Task & Run It
        let downloadTask = downloadSession.downloadTask(with: url) { fileURL, response, error in
            if let error = error {
                
                ILog.debug(tag: #file, content: "error \(error)")
               
            } else {
                
                ILog.debug(tag: #file, content: "Our local URL = \(fileURL?.absoluteString ?? "")")
                
                //1. Create The Filename
                let myFileUrl = self.getDocumentsDirectory().appendingPathComponent("test1.glb")
                
                //2. Copy It To The Documents Directory
                do {
                    try FileManager.default.copyItem(at: fileURL!, to: myFileUrl)
                    
                    ILog.debug(tag: #file, content: "Successfuly Saved File \(myFileUrl)")
                    
                    ThreadUtility.startUIThread {
                        //3. Load The Model
                        self.loadModel()
                    }
                   
                    
                } catch {
                    
                    ThreadUtility.startUIThread {
                        //3. Load The Model
                        ILog.debug(tag: #file, content: "Error Saving: \(error)")
                        self.loadModel()
                    }
                }
            }
        }
        
        downloadTask.resume()
        
        ILog.debug(tag: #file, content: "run download")
    }
    
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//
//        ILog.debug(tag: #file, content: "urlSession")
//
//        //1. Create The Filename
//        let fileURL = getDocumentsDirectory().appendingPathComponent("test.usdz")
//
//        //2. Copy It To The Documents Directory
//        do {
//            try FileManager.default.copyItem(at: location, to: fileURL)
//
//            ILog.debug(tag: #file, content: "Successfuly Saved File \(fileURL)")
//
//            //3. Load The Model
//            loadModel()
//
//        } catch {
//
//            ILog.debug(tag: #file, content: "Error Saving: \(error)")
//            loadModel()
//        }
//
//    }
    
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
        
    }
    
    func loadModel() {
        
        ILog.debug(tag: #file, content: "loadModel")
        
        //1. Get The Path Of The Downloaded File
//        let downloadedScenePath = getDocumentsDirectory().appendingPathComponent("3d_model_animation_kalug.usdz")
        
//        self.scnView.autoenablesDefaultLighting = true
//        self.scnView.showsStatistics=true
//        self.scnView.backgroundColor = UIColor.blue
//        let asset = MDLAsset(url: downloadedScenePath)
//        let scene = SCNScene(mdlAsset: asset)
//        self.scnView.scene=scene
//        self.scnView.allowsCameraControl=true
        
//        scene = SCNScene(named: "3d_model_animation_kalug.usdz")
        
//        let asset = MDLAsset(url: downloadedScenePath)
//        let scene = SCNScene(mdlAsset: asset)
//
//        scnView.scene = scene
//
//        /*
//         allows the user to manipulate the camera
//         -单指滑动:旋转相机;
//         -双指滑动:移动相机;
//         -双指捏合:缩放;
//         -双击:如果有两个相机则切换,一个相机则返回原始状态;
//         */
//        scnView.allowsCameraControl = true
//
//        // show statistics such as fps and timing information
//        scnView.showsStatistics = true
//
//        scnView.autoenablesDefaultLighting = true
//
//        // configure the view
//        scnView.backgroundColor = UIColor.clear
        
        //1. Get The Path Of The Downloaded File
        let downloadedScenePath = getDocumentsDirectory().appendingPathComponent("test1.glb")
        
        self.scnView.autoenablesDefaultLighting=true
        self.scnView.showsStatistics=true
        self.scnView.backgroundColor = UIColor.black
        
//        let asset = MDLAsset(url: downloadedScenePath)
//        asset.loadTextures()
//        let scene = SCNScene(mdlAsset: asset)
        
        do {
            let sceneSource = GLTFSceneSource(url: downloadedScenePath)
            let scene: SCNScene = try sceneSource.scene()
            
            self.scnView.scene=scene
            self.scnView.allowsCameraControl=true
            
        } catch {
            
            ILog.debug(tag: #file, content: error.localizedDescription)
            return
        }
        
//        let sceneSource = try GLTFSceneSource(url: downloadedScenePath)
//        let scene: SCNScene = try sceneSource.scene()
//
//        self.scnView.scene=scene
//        self.scnView.allowsCameraControl=true
        
    }
    
    
    private func setupSceneView() {
        
        scene = SCNScene(named: "3d_model_animation_kalug.usdz")
        
//        do {
//
////            if let url = URL(string: "https://dl.dropboxusercontent.com/s/jqehg953j5e4qed/converse_obj.scn?dl=0") {
////            if let url = URL(string: "https://dl.dropboxusercontent.com/s/77wsgpz2zoalvkt/3d_model_animation_kalug.usdz") {
////                try scene = SCNScene(url: url)
////
////
////            }
//
//
//        }
//        catch {
//            ILog.debug(tag: #file, content: "\(error)")
//        }
//
       
        ILog.debug(tag: #file, content: "setupSceneView \(scene == nil)")
        scnView.scene = scene

        /*
         allows the user to manipulate the camera
         -单指滑动:旋转相机;
         -双指滑动:移动相机;
         -双指捏合:缩放;
         -双击:如果有两个相机则切换,一个相机则返回原始状态;
         */
        scnView.allowsCameraControl = true

        // show statistics such as fps and timing information
        scnView.showsStatistics = true

        scnView.autoenablesDefaultLighting = true

        // configure the view
        scnView.backgroundColor = UIColor.clear
    }
    
    private func setupCamera() {
        // 1.创建空的节点
        let cameraNode = SCNNode()
        // 2.创建相机,添加到节点中
        cameraNode.camera = SCNCamera()
        // 3.设置相机节点的位置
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        // 4.添加到根节点中
        scene?.rootNode.addChildNode(cameraNode)
    }
    
    private func setupLight() {
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene?.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
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
