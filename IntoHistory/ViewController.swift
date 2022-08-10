//
//  ViewController.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/05.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var heroListView = HeroListView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = heroListView
    }
}

