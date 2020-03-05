//
//  StoreDetailViewController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/04.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    //MARK: - Properties
    var storeDetailView: StoreDetailView!
    
    //MARK: - Helper Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        customizeNav()
        configureSubView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        storeDetailView.frame = CGRect(x: view.bounds.origin.x, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
    }
    
    func configureSubView() {
        storeDetailView = StoreDetailView()
        storeDetailView.backgroundColor = UIColor(red: 189/255, green: 183/255, blue: 107/255, alpha: 1)
        
        view.addSubview(storeDetailView)
    }
    
    func customizeNav() {
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "詳細画面"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ナビ開始", style: .plain, target: self, action: #selector(startNav))
        
    }
    
    //MARK: - Selectors
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func startNav() {
        print("start navgation..")
    }
    
}
