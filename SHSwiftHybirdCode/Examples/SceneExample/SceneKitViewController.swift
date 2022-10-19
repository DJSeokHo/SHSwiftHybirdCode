//
//  SceneKitViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/18.
//

import UIKit
import SwiftUI
import SceneKit
import Foundation

class SceneKitViewController: UIViewController {

    private let scene = SCNScene()
    
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
//        createRootNode()
    }
    
    private func setupSceneView() {
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
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3.0)
        // 4.添加到根节点中
        scene.rootNode.addChildNode(cameraNode)
    }
    
    private func setupLight() {
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 1, z: 0)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
    }
    
    private func createRootNode() {

        // 想要绘制的 3D 立方体, 0.1米 x 0.1米 x 0.1米
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        boxGeometry.firstMaterial?.diffuse.contents = UIColor.red
        boxGeometry.firstMaterial?.isDoubleSided = true
        
        // 将几何体包装为 node 以便添加到 scene
        let boxNode = SCNNode(geometry: boxGeometry)

        // 把 box 放在摄像头正前方
        boxNode.position = SCNVector3Make(0.0, 0.0, -1.0)

        // rootNode 是一个特殊的 node，它是所有 node 的起始点
        scene.rootNode.addChildNode(boxNode)
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
