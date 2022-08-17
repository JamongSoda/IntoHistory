//
//  ARViewController.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/12.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

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
            let node = hitResults[0].node

            // TODO: - 미뉴가 만든 팝업 present + 밑에 버튼 놔야할듯? ("돌아가기")이런거,,
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
