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

class Scene3DModelViewController: UIViewController {

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
        
        setupSceneView()
        setupCamera()
        setupLight()
        
    }
    
    private func setupSceneView() {
        
        scene = SCNScene(named: "3d_model_animation_kalug.usdz")
        
//        do {
//
//            if let url = URL(string: "https://dl.dropboxusercontent.com/s/jqehg953j5e4qed/converse_obj.scn?dl=0") {
//                try scene = SCNScene(url: url)
//            }
//        }
//        catch {
//            ILog.debug(tag: #file, content: "\(error)")
//        }
        
       
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
