//
//  ProfileViewController.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit
import DatePicker
import KeyboardAvoidingView

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    private let presenter = ProfilePresenter(service: ProfileService())
    
    private let firstJanuary1950 = Date(timeIntervalSince1970: -631100000)
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var editProfileImageButton: UIButton!
    
    @IBOutlet weak var staticView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullBirthdayLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    
    var isEditingMode = false
    
    let datePicker = DatePicker()
    
    var birthday:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
        self.setupandHandleDatePicker()
        self.addGlobalTapGesture()
        self.addEditButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainScrollView.contentSize = self.containerView.frame.size
    }
    
    
    func setup() {
        self.title = profileTitle
        self.presenter.viewController = self
        self.presenter.setDelegate(delegate: self)
        self.presenter.getCurrentUser()
        self.profileImageView.applyHorizontalRounded(borderWidth: 3.0, borderColor: UIColor.lightGray, shadow: true)
        
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        self.showSourceChoice()
    }
    
    @IBAction func modifyBirthdayAction(_ sender: UIButton) {
        self.view.endEditing(true)
        datePicker.display(in: self)
    }

    func showSourceChoice() {
        let alert = UIAlertController(title: sourceSelectionTitle, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: sourceCameraButtonTitle, style: .default) { (_) in
            self.openCamera()
        }
        let albumAction = UIAlertAction(title: sourceAlbumButtonTitle, style: .default) { (_) in
            self.openAlbum()
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        #if !targetEnvironment(simulator)
        alert.addAction(cameraAction)
        #endif
        alert.addAction(albumAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - hide Keyboard

extension ProfileViewController {
    func addGlobalTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapGesture() {
        self.view.endEditing(true)
    }
}

//MARK: - UIImagePicker delegate

extension ProfileViewController {
    func openAlbum() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] {
            self.profileImageView.image = image as? UIImage
        } else if let image = info[.originalImage] {
            self.profileImageView.image = image as? UIImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UIImagePicker delegate

extension ProfileViewController:ProfileViewContract {
    func didUpdateUser() {
        
    }
    
    func didGetCurrentUer(user: User?) {
        guard let user = user else {
            return
        }
        self.nameTextField.text = user.name
        self.lastNameTextField.text = user.lastname
        self.addressTextField.text = user.address
        self.postalCodeTextField.text = "\(user.postalcode)"
        self.townTextField.text = user.town
        if let imageData = user.profil {
            self.profileImageView.image = UIImage(data: imageData)
        }
        
        self.fullNameLabel.text = "Nom : \(user.name ?? "") \(user.lastname ?? "")"
        if let address = user.address,
            user.postalcode != 0,
            let town = user.town {
            self.fullAddressLabel.text = "Address : \(address), \(user.postalcode) \(town)"
        }
        if let birthday = user.birthday {
            self.fullBirthdayLabel.text = "Naissance : \(birthday.toString(dateFormat: birthdayDateFormat))"
        }
    }
}

//MARK: - DatePicker

extension ProfileViewController {
    func setupandHandleDatePicker() {
        datePicker.setup(min: firstJanuary1950, max: Date()) { (selected, date) in
            if selected, let date = date{
                self.birthdayTextField.text = date.toString(dateFormat: birthdayDateFormat)
                self.birthday = date
            }
        }
    }
}

//MARK: - Edit/Save actions

extension ProfileViewController {
    func addEditButton() {
        let editButton = UIBarButtonItem(title: editButtonTitle, style: .plain, target: self, action: #selector(beginEditing))
        self.navigationItem.rightBarButtonItem = editButton
        self.editProfileImageButton.isHidden = true
    }
    
    func addSaveButton() {
        let saveButton = UIBarButtonItem(title: saveButtonTitle, style: .plain, target: self, action: #selector(endEditing))
        self.navigationItem.rightBarButtonItem = saveButton
        self.editProfileImageButton.isHidden = false
        self.addCancelButton()
    }
    
    func addCancelButton() {
        let cancelButton = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(cancelEditing))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.editProfileImageButton.isHidden = false
    }
    
    func removeCancelButton() {
        self.navigationItem.leftBarButtonItem = nil
    }
    
    @objc func beginEditing() {
        self.isEditingMode = true
        self.staticView.animateHide()
        self.addSaveButton()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
        self.addEditButton()
        self.isEditingMode = false
        self.presenter.updateUser()
        self.staticView.animateShow()
        self.removeCancelButton()
    }
    
    @objc func cancelEditing() {
        self.view.endEditing(true)
        self.addEditButton()
        self.isEditingMode = false
        self.staticView.animateShow()
        self.removeCancelButton()
    }
}

extension ProfileViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
