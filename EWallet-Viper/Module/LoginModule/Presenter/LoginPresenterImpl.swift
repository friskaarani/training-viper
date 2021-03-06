//
//  LoginPresenterImpl.swift
//  ZWallet
//
//  Created by user217917 on 3/31/22.
//

import Foundation
import UIKit

class LoginPresenterImpl: LoginPresenterProtocol {
    let view: LoginViewProtocol
    let interactor: LoginInteractorProtocol
    let router: LoginRouterProtocol
    
    init(view: LoginViewProtocol, interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func didTappedBtnLogin(email: String, password: String) {
        self.interactor.postLoginData(email: email, password: password)
    }
    
    func didTappedBtnSignUp(viewController: UIViewController) {
        self.router.navigateToRegister(viewController: viewController)
    }
}

extension LoginPresenterImpl: LoginInteractorOutputProtocol {
    func authenticationResult(isSuccess: Bool) {
        if isSuccess {
            let checkPin : Bool = UserDefaultHelper.shared.get(key: .userHasPin) ?? false
            if(checkPin == false){
                self.router.navigateToCreatePIN()
            }
            else {
                self.router.navigateToHome()
            }
        } else {
            self.view.showError()
        }
    }
    
}
