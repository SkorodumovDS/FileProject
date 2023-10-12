//
//  SettingsViewController.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 12.10.2023.
//

import UIKit
import KeychainSwift

class SettingsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private enum CellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
        case resetPassword = "ResetTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    private func tuneTableView() {
        // 2. Настраиваем отображение таблицы
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 150.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        // 3. Указываем, с какими классами ячеек и кастомных футеров / хэдеров
        //    будет работать таблица
        tableView.register(
            ResetPasswordTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.resetPassword.rawValue
        )

        tableView.register(
            SettingTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
        
        // 4. Указываем основные делегаты таблицы
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { if section == 0 {
        return 2}
        else {return 2}
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.base.rawValue,
                for: indexPath
            ) as? SettingTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.resetPassword.rawValue,
            for: indexPath
        ) as? ResetPasswordTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
            return cell
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if indexPath.row == 1 {
            let keychain = KeychainSwift()
            keychain.set("", forKey: "password")
            
            let passwordNavController = UINavigationController()
            let passwordVC = Factory(flow: .password, navigation: passwordNavController)
            
            navigationController?.tabBarController?.viewControllers = [passwordVC.navigationController]
        }else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell_ReuseID", for: indexPath) as! SettingTableViewCell
            cell.sortingSwitchValueChanged()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat { if section == 0 {
        return 0}
        else {return 0 }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return nil
    }
}



