//
//  LoginViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/02.
//

import UIKit

class LoginViewController: UIViewController {

    let loginTitle: UILabel = {
        let label = UILabel()
        label.text = " LOG IN"
        label.textColor = .black
        
        label.font = UIFont(name: customfont.잉크링퀴드.rawValue, size: 50)
        
        
        return label
    }()
    
    let IDBOX: UITextField = {
        let tf = UITextField()
        
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.placeholder = "아이디를 입력하세요."
        
        tf.addleftpadding()
        
        return tf
    }()
    
    let PASSWORDBOX: UITextField = {
        let tf = UITextField()
        
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.placeholder = "비밀번호를 입력하세요."
        tf.isSecureTextEntry = true
        
        tf.addleftpadding()
        
        return tf
    }()
    
    let loginbt : UIButton = {
        let bt = UIButton()
        
        bt.setTitle("Log in", for: .normal)
        bt.backgroundColor = UIColor.init(red: 226/255, green: 226/255, blue: 249/255, alpha: 1)
        bt.setTitleColor(.white, for: .normal)
        
        return bt
    }()
    
    let dissmissbt: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("취소", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        
        return bt
    }()
    
    
    func addview() {
        view.addSubview(loginTitle)
        view.addSubview(IDBOX)
        view.addSubview(PASSWORDBOX)
        view.addSubview(loginbt)
        view.addSubview(dissmissbt)
        
        
    }
    
    func autolayout() {
        
        loginTitle.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/4)

        }
        
        IDBOX.snp.makeConstraints { make in
            make.top.equalTo(loginTitle.snp.bottom).offset(view.frame.height/20)
            make.centerX.equalTo(view)
            make.height.equalTo(view.frame.height/15)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            
        }
        
        PASSWORDBOX.snp.makeConstraints { make in
            make.top.equalTo(IDBOX.snp.bottom).offset(view.frame.height/40)
            make.centerX.equalTo(view)
            make.height.equalTo(view.frame.height/15)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            
        }
        
        loginbt.snp.makeConstraints { make in
            make.leading.trailing.equalTo(IDBOX)
            make.top.equalTo(PASSWORDBOX.snp.bottom).offset(view.frame.height/40)
            make.height.equalTo(PASSWORDBOX)
        }
        
        dissmissbt.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(view.frame.width/20)
            make.top.equalTo(view).offset(view.frame.height/20)
        }
    
        
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        addview()
        autolayout()
        
        view.backgroundColor = .white
        
        IDBOX.delegate = self
        PASSWORDBOX.delegate = self
        
        loginbt.addTarget(self, action: #selector(pressloginbt(_:)), for: .touchUpInside)
        dissmissbt.addTarget(self, action: #selector(pressdissmissbt(_:)), for: .touchUpInside)
    }
    
    @objc func pressloginbt(_ sender:UIButton) {
        
        sendlogin()
        
        
    }
    
    @objc func pressdissmissbt(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func sendlogin() {
        login = .login
        print("try login")
    }
    
    
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if IDBOX.isFirstResponder {
            
            PASSWORDBOX.becomeFirstResponder()
    
        } else if PASSWORDBOX.isFirstResponder {
            
            PASSWORDBOX.resignFirstResponder()
            sendlogin()
        }
        
        return true
    }
}

extension UITextField {
    func addleftpadding() {
        let leftpadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = leftpadding
        leftViewMode = .always
    }
}
