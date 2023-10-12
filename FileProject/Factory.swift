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
        case settings
        case password
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
            viewController = DocumentsViewController
        case .settings:
            let SettingsViewController = SettingsViewController()
            SettingsViewController.title = "Settings"
            SettingsViewController.view.backgroundColor = .systemBackground
            SettingsViewController.tabBarItem.title = "Settings"
            SettingsViewController.tabBarItem.image = UIImage(systemName: "gear")
            navigationController.setViewControllers([SettingsViewController], animated: true)
            viewController = SettingsViewController
        case .password:
            let documentCoordinator = DocumentCoordinator()
            documentCoordinator.navControlles = navigationController
            let PasswordViewController = PasswordViewController(coordinator: documentCoordinator)
            PasswordViewController.title = "Авторизация"
            PasswordViewController.view.backgroundColor = .systemBackground
            PasswordViewController.tabBarItem.title = "Авторизация"
            PasswordViewController.tabBarItem.image = UIImage(systemName: "gear")
            navigationController.setViewControllers([PasswordViewController], animated: true)
            
        }
    }
    
}

