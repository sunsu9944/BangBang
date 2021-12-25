//
//  addressTableViewCell.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/30.
//

import UIKit
import SnapKit

class addressTableViewCell: UITableViewCell {

    static let identifier = "addressTableViewCellidentifier"
    
    let address = UILabel()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        address.text = "도로명 주소"
        address.font = UIFont.boldSystemFont(ofSize: 15)
        address.adjustsFontForContentSizeCategory = true
        address.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(address)
        
        address.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(30)
            make.centerY.equalTo(contentView)
        }

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
