//
//  festivalview.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/28.
//

import UIKit
import Pods_BangBang
import SnapKit
import Alamofire

class festivalview: UIButton {
    
    var festivalindex = 0
    
    let img:UIImageView = {
        let mv = UIImageView()
        
        mv.backgroundColor = .systemGray5
        mv.layer.cornerRadius = 15
        mv.layer.masksToBounds = true
    
        return mv
    }()
    
    let festivaltime: UILabel = {
        let label = UILabel()
        
        label.text = "시간"
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let festivalname: UILabel = {
        let label = UILabel()
        
        label.text = "축제이름"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    
    func addviews() {
        
        addSubview(img)
        addSubview(festivaltime)
        addSubview(festivalname)

    }
    
    func autolayout() {
        
        img.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.bottom.equalTo(self.snp.centerY).offset(50)
            make.top.equalTo(self).offset(10)
        }
        
        festivaltime.snp.makeConstraints { make in
            make.leading.equalTo(img)
            make.top.equalTo(img.snp.bottom).offset(10)
            make.trailing.equalTo(self).offset(-30)
        }
        festivalname.snp.makeConstraints { make in
            make.top.equalTo(festivaltime.snp.bottom).offset(5)
            make.leading.equalTo(festivaltime)
            make.bottom.equalTo(self).offset(-10)
            make.trailing.equalTo(self).offset(-15)
        }
    }
    
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        layer.cornerRadius = 15
        addviews()
        autolayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadimage() {
        
        guard let imgurl = LoadFestivalData.shared.festivaltour[festivalindex].imagepath else { return}
        
        AF.request(imgurl, method: .get).response{ response in
            
            switch response.result {
            case.success(let responseData):
                self.img.image = UIImage(data: responseData!, scale: 1)
                
            case .failure(let error):
                print("error",error)
            }
        }
        
    }
}


