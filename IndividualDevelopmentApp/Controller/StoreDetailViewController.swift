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
    var storeName: String!
    var storeReview: String!
    var storeImage: String!
    var count: Int!
    
    init(storeName: String, storeReview: String, storeImage: String, count: Int) {
        super.init(nibName: nil, bundle: nil)
        self.storeName = storeName
        self.storeReview = storeReview
        self.storeImage = storeImage
        self.count = count
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        storeDetailView.backgroundColor = UIColor(red: 162/255, green: 99/255, blue: 24/255, alpha: 1)
        let url = URL(string: storeImage)
        do {
            let data = try Data(contentsOf: url!)
            self.storeDetailView.storeImageView.image = UIImage(data: data)
            print("did set user image from database..")
        } catch _ {
            print("error..")
        }
        storeDetailView.storeNameLabel.text = self.storeName
        storeDetailView.storeImpresstionLabel.text = self.storeReview
        
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
