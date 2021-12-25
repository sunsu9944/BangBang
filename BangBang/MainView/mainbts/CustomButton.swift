//
//  CustomButton.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/29.
//

import UIKit

class CustomButton: UIButton {
    
    let btTitle: UILabel = {
        let label = UILabel()
        
        label.text = "버튼이름"
        label.font = UIFont(name: "THEFACESHOP", size: 30)
        
        return label
    }()
    
    let btimg: UIImageView = {
        let imgv = UIImageView()
       // imgv.backgroundColor = .white
        return imgv
    }()
    
    func addviews() {
        addSubview(btTitle)
        addSubview(btimg)
    }
    
    func autolayout() {
        btTitle.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(30)
            make.top.equalTo(self).offset(30)
        }
        
        btimg.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(80)
            make.trailing.equalTo(self).offset(-30)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
    }
    
    override init(frame: CGRect) {//초기화
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 15
        
        addviews()
        autolayout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
