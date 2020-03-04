//
//  SideMenuController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/02/29.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

protocol SideMenuControllerDelegate {
    func hideSideMenu(forSideMenuOption sideMenuOption: SideMenuOption)
}

class SideMenuController: UIViewController {
    
    // MARK: - Properties
    var sideMenuTableView: UITableView!
    var delegate: SideMenuControllerDelegate?
    
    // MARK: - Helper Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sideMenuTableView.translatesAutoresizingMaskIntoConstraints = false
        sideMenuTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sideMenuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sideMenuTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sideMenuTableView.topAnchor.constraint(equalTo: view.topAnchor ).isActive = true
    }
    
    func configureTableView() {
        
        let localSideMenuTable = SideMenuTableView(backgroundColor: .gray, rowHeight: 80)
        localSideMenuTable.delegate = self
        localSideMenuTable.dataSource = self
        sideMenuTableView = localSideMenuTable
        
        view.addSubview(sideMenuTableView)
        
    }
    
}

extension SideMenuController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiler , for: indexPath) as! SideMenuOptionCell
        let sideMenuOption = SideMenuOption(rawValue: indexPath.row)
        cell.selectionStyle = .none
        cell.descriptionLabel.text = sideMenuOption?.description
        cell.iconImageView.image = sideMenuOption?.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sideMenuOption = SideMenuOption(rawValue: indexPath.row)
        delegate?.hideSideMenu(forSideMenuOption: sideMenuOption!)
    }
    
}
