//
//  ARViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/14.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var arSceneView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initARView()
        
        self.initARSession()
    }
    
    /**
     初始化AR和Scene
     */
    private func initARView() {
        
        // Do any additional setup after loading the view.
        arSceneView.delegate = self
        
        // Show statistics such as fps and timing information
        arSceneView.showsStatistics = true
        
        arSceneView.debugOptions = [
            //ARSCNDebugOptions.showFeaturePoints,
            //ARSCNDebugOptions.showWorldOrigin,
            //SCNDebugOptions.showBoundingBoxes,
            //SCNDebugOptions.showWireframe
        ]
        
        if let scene = SCNScene(named: "ARResource.scnassets/SimpleScene.scn") {
            arSceneView.scene = scene
        }
    }
    
    func initARSession() {
        guard ARWorldTrackingConfiguration.isSupported else {
            // 可以使用 类的isSupported属性来检查设备是否支持该配置。3DOF 和 6DOF
            /*
             在启动AR session,之前,必须创建AR session conﬁguration （AR 会话配置）。此配置用于在真实世界(设备所在的位置)和虚拟 3D 世界(虚拟内容所在的位置)之间建立连接。

             有两种类型的配置：

             AROrientationTrackingConfiguration, 用于三个自由度跟踪, 简称3DOF。
             3DOF跟踪设备旋转,分为Pitch（俯仰）、Roll（滚动）和 Yaw（偏航） 组件,表示围绕X 轴、Y 轴和 Z 轴的旋转。这由 AR 定向跟踪配置会话配置类型支持。
             
             ARWorldTrackingConfiguration，用于六个自由度跟踪, 简称 6DOF。
             6DOF 跟踪Pitch、Roll和 Yaw,类似于 3DOF。它还使用 Sway、Heave 和 Surge 组件跟踪 3D 空间中的设备移动。这些新组件表示与 X 轴、Y 轴和 Z 轴平行的移动。这由 ARWorldTrack 配置会话配置类型支持。

             */
            ILog.debug(tag: #file, content: "*** ARConfig: AR World Tracking Not Supported")
            return
        }
        
        // 首先,创建一个 ARWorldTrackingConfiguration配置实例, 该实例已分配给config。
        let config = ARWorldTrackingConfiguration()
        
        /*
         设置worldAlignment属性,用于指定虚拟内容与真实世界的关系。这里有三个选项:
          a) gravity: 这将设置虚拟内容坐标系的 Y 轴,与地球引力平行。这可确保 Y 轴始终在实际空间中向上指向。它还使用设备的初始位置作为坐标系源,称为世界原点。这是 AR 会话开始时设备在真实世界中的位置。
          b) gravityAndHeading：这还会设置虚拟内容坐标系的 Y 轴,与重力平行。它还定向 X 轴,使其从西向东运行,并且 Z 轴,以便从北到南运行:
          最后,它还使用设备的初始位置作为世界起源。例如,你可以使用它将用户指向真实世界的指南针方向。
          c)camera：这将使用设备方向和 3D 空间中的位置作为世界原点。例如,用户可以在启动 AR 会话之前将其设备放在墙上。
         */
        config.worldAlignment = .gravity
        
        // 通过将providesAudioData设置为false来禁用该功能。此属性允许 AR 会话捕获音频。
        config.providesAudioData = false
        
        config.planeDetection = .horizontal
        
        arSceneView.session.run(config)
    }
    
    // MARK: - Functions for standard AR view handling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        arSceneView.session.run(configuration)
        arSceneView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arSceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
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
