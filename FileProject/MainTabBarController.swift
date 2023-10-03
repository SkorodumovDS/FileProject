//
//  MainTabBarController.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 01.10.2023.
//

import UIKit

final class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControlles()
    }
    
    private func setControlles() {
       
        let documentsNavController = UINavigationController()
        let documentsVC = Factory(flow: .documents, navigation: documentsNavController)
        
        viewControllers = [documentsVC.navigationController]
    }
}
