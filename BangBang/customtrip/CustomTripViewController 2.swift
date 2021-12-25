//
//  CustomTripViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/05.
//

import UIKit

class CustomTripViewController: UIViewController {

    
    var select: [customTripButton] = []
    var titlename = ["강아지","거동불편자","노약자","아기","시각장애인"]

    
    func addselectbt() {
        
        for i in 0..<5 {
            select.append(customTripButton())
            select[i].title.text = titlename[i]
            select[i].check = .notchecked
            
            view.addSubview(select[i])
        }
 
    }
    
    
    
    
    
    func autolayout() {
        
        for i in 0..<5 {
            if i % 2 == 0 {
                select[i].snp.makeConstraints { make in
                    make.leading.equalTo(view).offset(30)
                    make.trailing.equalTo(view.snp.centerX).offset(-10)
                }
            } else {
                
                select[i].snp.makeConstraints { make in
                    make.leading.equalTo(view.snp.centerX).offset(10)
                    make.trailing.equalTo(view).offset(-30)
                }
            }
            
            if i <= 1 {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(view).offset(100)
                }
            } else if i <= 3 {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(select[1].snp.bottom).offset(10)
                }
            } else {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(select[3].snp.bottom).offset(10)
                }
            }
            
            select[i].snp.makeConstraints { make in
                make.height.equalTo(view.frame.height/20)
            }
        }
        
        
        
        
    }
    
    
    func addview() {
        addselectbt()
        
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        addview()
        autolayout()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
