//
//  InstitutionalTabBarController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 21.04.2024.
//

import UIKit

class InstitutionalTabBarController: UITabBarController {


        override func viewDidLoad() {
            super.viewDidLoad()
            print(tabBar) // tabBar'ın değerini kontrol etmek için debug mesajı ekle
            
            tabBar.backgroundColor = .lightGray
            
            
            // TabBarItem'ların ikon ve yazı renklerini beyaz yap
            let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .selected)
            // Do any additional setup after loading the view.
            if let homeTabItem = tabBar.items?[0]{
                homeTabItem.image = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal)
                homeTabItem.title = "Anasayfa"
            }
            
            if let profileTabItem = tabBar.items?[1] {
                profileTabItem.image = UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal)
                profileTabItem.title = "Profil"
                
            }
        }
}
