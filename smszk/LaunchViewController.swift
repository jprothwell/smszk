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
        
        let nav = UINavigationController(rootViewController: HomeViewController())
        
        let backImage = UIImage(named: "Back")
        
        nav.navigationBar.tintColor = UIColor(red: 66.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        nav.navigationBar.backIndicatorImage = backImage
        nav.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
}
