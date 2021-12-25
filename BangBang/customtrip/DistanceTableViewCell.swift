//
//  DistanceTableViewCell.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/07.
//

import UIKit
import Alamofire

class DistanceTableViewCell: UITableViewCell {
    
    static let distancetableViewCellindentifeir = "DistanceTalbeViewCellIdentifier"
    
    
    let distancelabel: UILabel = {
        let label = UILabel()
        
        label.text = "distance"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: customfont.잉크링퀴드.rawValue , size: 30)
        
        return label
    }()
    
    let tablearrow: UIImageView = {
        let v = UIImageView()
        
        v.image = UIImage.init(systemName: "chevron.right")
        
        return v
    }()
    
    func addview() {
        
        contentView.addSubview(distancelabel)
        contentView.addSubview(tablearrow)
    }
    
    func autolayout() {
        
        distancelabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(30)
            make.centerY.equalTo(self)
        }
        
        tablearrow.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-30)
            make.centerY.equalTo(self)
//            make.top.equalTo(self).offset(10)
//            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(distancelabel.snp.height)
            make.width.equalTo(tablearrow.snp.height)
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
