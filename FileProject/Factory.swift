//
//  Factory.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 01.10.2023.
//

import UIKit

final class Factory {
    enum Flow {
        case documents
    }
    
    private let flow : Flow
    private (set) var navigationController = UINavigationController()
    private (set) var viewController : UIViewController?
    
    init(flow: Flow, navigation: UINavigationController) {
        self.flow = flow
        self.navigationController = navigation
        startModule()
    }
    
    private func startModule() {
        
        switch flow {
        case .documents:
            let DocumentsViewController = DocumentsViewController()
            DocumentsViewController.title = "Documents"
            DocumentsViewController.view.backgroundColor = .systemBackground
            DocumentsViewController.tabBarItem.title = "Documents"
            DocumentsViewController.tabBarItem.image = UIImage(systemName: "folder")
            navigationController.setViewControllers([DocumentsViewController], animated: true)
            
        }
    }
    
}

