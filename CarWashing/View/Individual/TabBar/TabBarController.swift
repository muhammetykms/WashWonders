//
//  TabBarController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 10.04.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        tabBar.backgroundColor = .lightGray
        navigationItem.hidesBackButton = true
        // TabBarItem'ların ikon ve yazı renklerini beyaz yap
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .selected)
        // Do any additional setup after loading the view.
        if let homeTabItem = tabBar.items?[0]{
            homeTabItem.image = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal)
            homeTabItem.title = "Anasayfa"
        }
        
        if let currentTabItem = tabBar.items?[1] {
            currentTabItem.image = UIImage(systemName: "clipboard")?.withRenderingMode(.alwaysOriginal)
            currentTabItem.title = "Güncel"
            
        }
        if let pastTabItem = tabBar.items?[2] {
            pastTabItem.image = UIImage(systemName: "doc.on.clipboard")?.withRenderingMode(.alwaysOriginal)
            pastTabItem.title = "Geçmiş"
            
        }
        if let profileTabItem = tabBar.items?[3] {
            profileTabItem.image = UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal)
            profileTabItem.title = "Profil"
            
        }
    }
    

}
