//
//  SettingTableViewCell.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 12.10.2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    
    private lazy var postTitle : UILabel = {
        let titlePost = UILabel()
        titlePost.translatesAutoresizingMaskIntoConstraints = false
        titlePost.text = "В алфавитном порядке"
        titlePost.font = .systemFont(ofSize: 20,weight: .bold)
        titlePost.textColor = UIColor.black
        titlePost.numberOfLines = 2
        
        return titlePost
        
    }()
    
    private lazy var postSwitch : UISwitch = {
        
        let titlePost = UISwitch()
        titlePost.translatesAutoresizingMaskIntoConstraints = false
        //titlePost.title = "В алфавитном порядке"
        titlePost.isOn = true
        titlePost.addTarget(self, action: #selector(sortingSwitchValueChanged), for: .valueChanged)
        return titlePost
        
    }()
    
   
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
            reuseIdentifier: reuseIdentifier
        )
        addsubviews()
        setupConstrains()
        let defaults = UserDefaults.standard
        let sorting  = defaults.bool(forKey: "Sorting")
        if sorting {postSwitch.isOn = true}
        else {postSwitch.isOn = false}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addsubviews(){
        addSubview(postTitle)
        addSubview(postSwitch)
    }
    
    private func setupConstrains() {
        
        let safeAreaLayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            postTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            postTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -76),
            postTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            postTitle.heightAnchor.constraint(equalToConstant: 35),
            
            postSwitch.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  -76),
            postSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            postSwitch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            postSwitch.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    
    @objc func  sortingSwitchValueChanged() {
        if postSwitch.isOn {
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "Sorting")
            postSwitch.isOn = false
        }
        else {
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "Sorting")
            postSwitch.isOn = true
        }
    }
}



