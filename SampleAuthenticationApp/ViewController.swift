//
//  ViewController.swift
//  SampleAuthenticationApp
//
//  Created by Ravi Tripathi on 22/02/18.
//  Copyright © 2018 Ravi Tripathi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, signUpComplete {
   
    //MARK: Implementaing go back mechanism after sign up
    func goBack() {
        displayCurrentTab(0)
    }
    
    //MARK: Initializing View Controllers
    
    var currentViewController: UIViewController?
    
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "login")
        return firstChildTabVC
    }()

    lazy var secondChildTabVC : SignupViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignupViewController
        return secondChildTabVC
    }()
    
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentViewController = firstChildTabVC
        displayCurrentTab(0)
        secondChildTabVC?.delegate = self
    }
    
    
    //MARK: - Handling Content View changes
    
    
    @IBOutlet weak var contentView: UIView!
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        var vc: UIViewController?
        switch tabIndex {
        case 0:
            vc  = firstChildTabVC
        case 1:
            vc = secondChildTabVC
        default:
            vc = firstChildTabVC
        }
        self.addChildViewController(vc!)
        vc!.didMove(toParentViewController: self)
        vc!.view.frame = self.contentView.bounds
        self.contentView.addSubview(vc!.view)
        self.currentViewController = vc
    }
    
}

