//
//  customButton.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/05.
//

import UIKit


enum ischeck {
    
    case notchecked
    case checked
    
}



class customTripButton: UIButton {
    
    
    var check: ischeck = .notchecked
    
    
    let title: UILabel = {
        let label = UILabel()
        
        label.text = "초기화"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let checkbt: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "diamond"), for: .normal)
        
        
        return bt
    }()
    
    
    
    
    
    
    func addviews() {
        
        addSubview(title)
        addSubview(checkbt)
        
        
        
    }
    
    func autolayout() {
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(30)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        checkbt.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing).offset(30)
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-30)
            make.height.equalTo(self).offset(-10)
        }
        
        
        
    }
    
    
    
    
    
    
    override init(frame: CGRect) {//초기화
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        
        
        addviews()
        autolayout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
