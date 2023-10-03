//
//  MainCoordinator.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 01.10.2023.
//

import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

final class MainCoordinatorImp : MainCoordinator {
    func startApplication() -> UIViewController {
        return MainTabBarController()
    }
}

