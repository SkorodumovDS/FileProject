//
//  PasswordTabBarController.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 12.10.2023.
//
import UIKit

final class PasswordTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControlles()
    }
    
    private func setControlles() {
       
        let passwordNavController = UINavigationController()
        let passwordVC = Factory(flow: .password, navigation: passwordNavController)
        
        viewControllers = [passwordVC.navigationController]
    }
}
