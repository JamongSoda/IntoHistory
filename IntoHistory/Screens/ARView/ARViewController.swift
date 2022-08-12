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
    private func addARView() {
        self.arscene = ARSCNView(frame : self.view.frame)
        self.view.addSubview(arscene)

        arscene.delegate = self
        arscene.showsStatistics = true

        let scene = SCNScene()
        let sphere = SCNSphere(radius: 0.2)
        sphere.firstMaterial?.diffuse.contents = UIImage(named : "testImage.jpg")

        let sphereNode = SCNNode(geometry : sphere)
        sphereNode.position = SCNVector3(0.5, 0.1, -1)
        scene.rootNode.addChildNode(sphereNode)

        let tapGestureRecognizer = UITapGestureRecognizer(target : self, action : #selector(tapped))
        self.arscene.addGestureRecognizer(tapGestureRecognizer)
        arscene.scene = scene
    }
