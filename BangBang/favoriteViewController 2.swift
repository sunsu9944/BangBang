//
//  favoriteViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/27.
//

import UIKit

class favoriteViewController: UIViewController {
    
 
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationAppearance(vc: self)
        checklogin(vc: self)
    }
    

}
