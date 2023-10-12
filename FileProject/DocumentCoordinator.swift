//
//  DocumentCoordinator.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 13.10.2023.
//

import UIKit

final class DocumentCoordinator {
    
    var navControlles : UINavigationController?
    
    func showNextScreen() {
       
        let documentsNavController = UINavigationController()
        let documentsVC = Factory(flow: .documents, navigation: documentsNavController)
       
        let settingsNavController = UINavigationController()
        let settingsVC = Factory(flow: .settings, navigation: settingsNavController)
        
       // navControlles?.setViewControllers([documentsVC.viewController!, settingsVC.viewController!], animated: true)
        //navControlles?.pushViewController(documentsVC.viewController!, animated: true)
        navControlles?.tabBarController?.viewControllers = [documentsVC.navigationController, settingsVC.navigationController]
    }
}
