//
//  resultTableViewCell.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/08.
//

import UIKit

class resultTableViewCell: UITableViewCell {
    
    static let idnentifier = "indentifier"
    
    
    let tname: UILabel = {
        let label = UILabel()
        
        label.text = "투어 이름"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        
        return label
    }()
    
    let address: UITextView = {
        let label = UITextView()
        
        label.text = "충청남도 아산시 호서로 104 - 22 신세기빌라 304호"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        
        
        return label
    }()
    
    let typelabel: UILabel = {
        let label = UILabel()
        
        label.text = "type"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        
        
        return label
    }()
    
    let tourimage: UIImageView = {
        let mv = UIImageView()
        
        mv.layer.cornerRadius = 15
        mv.layer.masksToBounds = true
        mv.backgroundColor = .systemGray5
        
        return mv
    }()
    
    
    
    func addview() {
        
        contentView.addSubview(tname)
        contentView.addSubview(address)
        contentView.addSubview(typelabel)
        contentView.addSubview(tourimage)
        
    }
    
    func autolayout() {
        
        tourimage.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(30)
            make.centerY.equalTo(contentView)
            make.top.equalTo(contentView).offset(30)
            make.bottom.equalTo(contentView).offset(-30)
            make.width.equalTo(contentView.snp.height)
        }
        
        tname.snp.makeConstraints { make in
            make.top.equalTo(tourimage).offset(10)
            make.leading.equalTo(tourimage.snp.trailing).offset(30)
            make.trailing.equalTo(contentView).offset(-30)
            make.height.equalTo(30)
        }
        
        typelabel.snp.makeConstraints { make in
            make.top.equalTo(tname.snp.bottom).offset(20)
            make.centerX.equalTo(tname)
            make.height.equalTo(20)
        }
        address.snp.makeConstraints { make in
            make.leading.equalTo(tname).offset(-20)
            make.trailing.equalTo(contentView).offset(-10)
            make.top.equalTo(typelabel.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(10)
        }
 
    }
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addview()
        autolayout()
        
        
        
        
        
        
        
        
        }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
