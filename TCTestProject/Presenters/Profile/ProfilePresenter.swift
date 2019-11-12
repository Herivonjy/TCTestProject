//
//  ProfilePresenter.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

protocol ProfileViewContract:NSObjectProtocol {
    func didUpdateUser()
    func didGetCurrentUer(user:User?)
}

class ProfilePresenter: NSObject {
    weak var viewController:ProfileViewController?
    private var delegate:ProfileViewContract?
    private let service:ProfileService
    
    
    init(service:ProfileService) {
        self.service = service
    }
    
    func setDelegate(delegate:ProfileViewContract?) {
        self.delegate = delegate
    }
    
    func getCurrentUser() {
        let user = DependancyInjectionCodeData.shared.getCurrentUser()
        self.delegate?.didGetCurrentUer(user: user)
    }
    
    func updateUser() {
        let user = User(name: viewController?.nameTextField.text,
                        lastname: viewController?.lastNameTextField.text,
                        address: viewController?.addressTextField.text,
                        postalcode: Int(viewController?.postalCodeTextField.text ?? "0") ?? 0,
                        town: viewController?.townTextField.text,
                        birthday: viewController?.birthday,
                        profil: viewController?.profileImageView.image?.pngData())
        if DependancyInjectionCodeData.shared.saveUser(user: user) {
            self.getCurrentUser()
        }
    }

}
