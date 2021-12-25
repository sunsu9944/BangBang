//
//  checklogin.swift.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/02.
//

import UIKit


func checklogin(vc:UIViewController) {
    
    switch login {
    case .notlogin:
        let alert = UIAlertController(title: "로그인이 필요합니다.", message: "로그인 하시겠습니까?", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "확인", style: .default) { action in
            print("popup loginView")
            let view = LoginViewController()
            view.modalPresentationStyle = .fullScreen
            vc.present(view, animated: true, completion: nil)
        }
        alert.addAction(alertaction)
        vc.present(alert, animated: true, completion: nil)
        
    case .login:
        print("alreadylogin")
    }
}

enum logined {
    case login
    case notlogin
}

var login: logined = .notlogin
