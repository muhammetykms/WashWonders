//
//  CustomButton.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 17.04.2024.
//

import UIKit

class CustomButton: UIButton {

    init(setTitle : String) {
        super.init(frame: .zero)
        self.setTitle(setTitle, for: .normal)
        setupButton()
    }
    required init?(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton (){
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        self.layer.cornerRadius = 20
    }
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
    }

}
