//
//  SignupViewController.swift
//  SampleAuthenticationApp
//
//  Created by Ravi Tripathi on 22/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import UIKit

protocol signUpComplete{
    func goBack()
}


class SignupViewController: UIViewController {
    
    // Keychain Configuration
    struct KeychainConfiguration {
        static let serviceName = "ArcAuth"
        static let accessGroup: String? = nil
    }

    var delegate : signUpComplete?
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signUp(_ sender: UIButton) {
        if let user = username.text, let pass = password.text, !user.isEmpty && !pass.isEmpty{
            do {
                // This is a new account, create a new keychain item with the account name.
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: user,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                // Save the password for the new item.
                try passwordItem.savePassword(pass)
                showSignupSuccessAlert()
            } catch {
                showSignupFailedAlert()
                fatalError("Error updating keychain - \(error)")
            }
        }
    }
    
    
    //Display Failure
    private func showSignupFailedAlert() {
        let alertView = UIAlertController(title: "Signup Problem",
                                          message: "Couldn't signup",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    //Display Already Exists
    private func userAlreadyExists() {
        let alertView = UIAlertController(title: "Signup Problem",
                                          message: "User already exists",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    //Display Success
    private func showSignupSuccessAlert(){
        let alert = UIAlertController(title: "Signup done!", message: "Please login now", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertActionStyle.default,
                                      handler: {(alert: UIAlertAction!) in
                                        self.delegate?.goBack()
                                        }
                                    )
                        )
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
