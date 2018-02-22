//
//  LoginViewController.swift
//  SampleAuthenticationApp
//
//  Created by Ravi Tripathi on 22/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    let touchMe = BiometricAuth()
    
    // Keychain Configuration
    struct KeychainConfiguration {
        static let serviceName = "ArcAuth"
        static let accessGroup: String? = nil
    }
    
    // Used apple's keychain code
    var passwordItems: [KeychainPasswordItem] = []
     
    @IBAction func touchID(_ sender: UIButton) {
        touchMe.authenticateUser() { [weak self] message in
            // 2
            if let message = message {
                // if the completion is not nil show an alert
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Darn!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
            } else {
                // 3
                self?.performSegue(withIdentifier: "dismissLogin", sender: self)
            }
        }
    }
    //Fields
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    //Authentication Button
    @IBAction func authenticate(_ sender: UIButton) {
        
        if let user = username.text, let pass = password.text, !user.isEmpty && !pass.isEmpty{
            if checkLogin(username: user, password: pass) {
                showLoginSuccessAlert()
            }else{
                showLoginFailedAlert()
            }
        }else{
            
        }
    }

    
    //Check credentials
    func checkLogin(username: String, password: String) -> Bool {
//        guard username == UserDefaults.standard.value(forKey: "username") as? String else {
//            print("No user")
//            return false
//        }
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: username,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            print(keychainPassword+":"+username)
            return password == keychainPassword
        } catch {
            print("Cant read:")
            return false
        }
    }
    
    //Display Failure
    private func showLoginFailedAlert() {
        let alertView = UIAlertController(title: "Login Problem",
                                          message: "Wrong username or password.",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Ok!", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    //Display Success
    private func showLoginSuccessAlert(){
        let alert = UIAlertController(title: "Authenticatin Success!", message: "You are authorized", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
}
