//
//  InitialViewController.swift
//  BloodMed
//
//  Created by Kenny Cardenas Reyes on 9/16/20.
//  Copyright © 2020 Kenny Cardenas Reyes. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @objc func showNavController(){
        performSegue(withIdentifier: "showSplash", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selector = #selector(self.showNavController)
        perform(selector, with: nil, afterDelay: 2)
    }

    
    

}

