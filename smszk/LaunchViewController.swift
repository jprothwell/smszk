//
//  LaunchViewController.swift
//  smszk
//
//  Created by LeonJing on 2019/2/18.
//  Copyright © 2019 LeonJing. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    override func loadView() {
        //super.loadView()
        
        let l = UILabel()
        l.backgroundColor = .white
        l.textAlignment = .center
        l.text = "免费短信接收"
        view = l
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: HomeViewController())
    }
}
