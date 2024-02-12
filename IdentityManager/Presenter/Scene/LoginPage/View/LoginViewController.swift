//
//  LoginViewController.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 08/02/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var viewModel: LoginViewModel!

    // MARK: - Lifecycle
    static func create(
        with viewModel: LoginViewModel
    ) -> LoginViewController {
        let view = LoginViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        view.backgroundColor = .red
    }
}

