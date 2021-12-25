//
//  NavigationBar.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/24.
//

import UIKit

func navigationtitle() -> UILabel {
    let label = UILabel()
    
    label.font = UIFont(name: "THEFACESHOP", size: 30)
    label.text = "위드윈드"
    label.textColor = .black
    
    
    return label
}

func navigationGPStitle() -> UILabel {
    let label = UILabel()
    
    label.font = UIFont(name: "THEFACESHOP", size: 30)
    label.text = "Gps 설정"
    label.textColor = .black
    
    
    return label
}

func navigationAppearance(vc: UIViewController) {
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.init(red: 226/255, green: 226/255, blue: 249/255, alpha: 1)
    vc.navigationController?.navigationBar.standardAppearance = appearance;
    vc.navigationController?.navigationBar.scrollEdgeAppearance = vc.navigationController?.navigationBar.standardAppearance
    
    vc.view.backgroundColor = .white
    
    vc.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
    vc.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 2, height: 2)
    vc.navigationController?.navigationBar.layer.shadowRadius = 1
    vc.navigationController?.navigationBar.layer.shadowOpacity = 0.4
    vc.navigationController?.navigationBar.layer.masksToBounds = false
    
    vc.navigationItem.titleView = navigationtitle()

}
