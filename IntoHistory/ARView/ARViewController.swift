//
//  ARViewController.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/17.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var courseInfo: CourseEntity?
    var heroInfo = coreDataManager.heros[0]

    // MARK: - View

    @IBOutlet var arscene: ARSCNView!

    // MARK: - Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addARView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        arscene.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        arscene.session.pause()
    }

    // MARK: - Method

    private func addARView() {
        self.arscene = ARSCNView(frame: self.view.frame)
        self.view.addSubview(arscene)

        arscene.delegate = self
        arscene.showsStatistics = true

        let scene = SCNScene()
        let sphere = SCNSphere(radius: 0.2)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "heroBallImage.png")

        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(0.5, 0.1, -1)
        scene.rootNode.addChildNode(sphereNode)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapARObject))
        self.arscene.addGestureRecognizer(tapGestureRecognizer)
        arscene.scene = scene
    }

    @objc func tapARObject(recognizer: UITapGestureRecognizer){
        let sceneView = recognizer.view as! SCNView
        let touchLocation: CGPoint = recognizer.location(in: sceneView)
        let hitResults: [SCNHitTestResult] = sceneView.hitTest(touchLocation, options: [:])

        if !hitResults.isEmpty {
            let vc = HeroCollectedViewController()
            coreDataManager.heros.forEach {
                if courseInfo?.cid == $0.hid {
                    heroInfo = $0
                }
            }
            vc.heroInfo = heroInfo
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

