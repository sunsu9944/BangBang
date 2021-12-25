//
//  UserViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/27.
//

import UIKit




class UserViewController: UIViewController {
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationAppearance(vc: self)
        checklogin(vc: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checklogin(vc: self)
        
        
    }
    
    
}



