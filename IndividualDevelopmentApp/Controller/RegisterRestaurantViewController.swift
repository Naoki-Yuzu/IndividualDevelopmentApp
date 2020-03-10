//
//  RegisterRestaurantViewController.swift
//  IndividualDevelopmentApp
//
//  Created by デュフフくん on 2020/03/01.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//

import UIKit

class RegisterRestaurantViewController: UIViewController {
    
    // MARK: - Properties
    let storeModel = RegisterStore()
    var activityIndicatorView: UIActivityIndicatorView!
    var registerRestaurantView: RegisterRestaurantView!
    var imageViewTapGesture: UITapGestureRecognizer!
    var editingTextView: UITextView?
    var longitude = MapView.longitude
    var latitude = MapView.latitude
    
    
    // MARK: - Helper Functions
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        configureObserver()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        cofigureSubView()
        customizeNav()
        configureIndicatorView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registerRestaurantView.frame = CGRect(x: view.bounds.origin.x ,y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height)
        
    }
    
    func cofigureSubView() {
        
        registerRestaurantView = RegisterRestaurantView()
        registerRestaurantView.impressionTextView.delegate = self
        registerRestaurantView.backgroundColor = .red
        view.addSubview(registerRestaurantView)
        
        configureImageTapGesture()
        
    }
    
    func customizeNav() {
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "新規投稿"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登録", style: .plain, target: self, action: #selector(register))
        
    }
    
    func configureImageTapGesture() {
        
        print("configure image tap gesture..")
        imageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        registerRestaurantView.storeImage.isUserInteractionEnabled = true
        registerRestaurantView.storeImage.addGestureRecognizer(imageViewTapGesture)
        
    }
    
    func configureImagePicker() {
           
           print("configure image picker..")
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = .photoLibrary
           present(imagePicker, animated: true, completion: nil)
           
    }
    
    func configureIndicatorView() {
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        view.addSubview(activityIndicatorView)
        
    }
    
    func configureObserver() {

        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(shiftUpView(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(shiftDownView(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    func removeObserver() {

        let notification = NotificationCenter.default
        notification.removeObserver(self)

    }
    
    //MARK: - Selectors
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func register() {
        activityIndicatorView.startAnimating()
        registerRestaurantView.impressionTextView.isUserInteractionEnabled = false
        registerRestaurantView.storeNameTextField.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        registerRestaurantView.storeImage.isUserInteractionEnabled = false
        print("register the store..")
        if registerRestaurantView.storeNameTextField.text == "" || registerRestaurantView.impressionTextView.text == "" {
            print("error")
        } else {
            guard let unwrappedLongitude = longitude, let unwrappedLatitude = latitude else { return }
            storeModel.registerStrore(storeImage: registerRestaurantView.storeImage.image!, storeName: registerRestaurantView.storeNameTextField.text!, storeImpression: registerRestaurantView.impressionTextView.text, longitude: unwrappedLongitude, latitude: unwrappedLatitude) {
                print("did finish..")
                self.activityIndicatorView.stopAnimating()
                self.registerRestaurantView.impressionTextView.isUserInteractionEnabled = true
                self.registerRestaurantView.storeNameTextField.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.registerRestaurantView.storeImage.isUserInteractionEnabled = true
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func openPhotoLibrary() {
        
        print("image view was tapped..")
        configureImagePicker()
        
    }
    
    @objc func shiftUpView(_ notification: Notification) {
        
        guard editingTextView != nil else { return }
        let rect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
          self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
        }
    }
    
    @objc func shiftDownView(_ notification: Notification) {
        
        guard editingTextView != nil else { return }
        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: {
            self.view.transform = CGAffineTransform.identity
        }) { (_) in
            self.editingTextView = nil
        }
    }
    
    
}

// MARK: - Delegate
extension RegisterRestaurantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        print("did select..")
        registerRestaurantView.storeImage.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterRestaurantViewController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        editingTextView = textView
        return true
    }

}
