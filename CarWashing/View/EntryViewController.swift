//
//  testViewController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 8.04.2024.
//

import UIKit

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Arka plan resimi
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        let titleLabel = UILabel()
        titleLabel.text = "WashWonders"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(titleLabel)
        
        let attributedText = NSMutableAttributedString(string: "Wash" , attributes: [NSAttributedString.Key.backgroundColor : UIColor.blue])
        attributedText.append(NSAttributedString(string: "Wonders", attributes: [NSAttributedString.Key.backgroundColor: UIColor.yellow]))
        titleLabel.attributedText = attributedText
        
        let individualButton = UIButton(type: .system)
        individualButton.setTitle("Bireysel Kullanıcı", for: .normal)
        individualButton.setTitleColor(.white, for: .normal)
        individualButton.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        individualButton.layer.cornerRadius = 20
        individualButton.addTarget(self, action: #selector(individualButtonClicked), for: .touchUpInside)
        view.addSubview(individualButton)
        
        let institutionalButton = UIButton(type: .system)
        institutionalButton.setTitle("Kurumsal Kullanıcı", for: .normal)
        institutionalButton.setTitleColor(.white, for: .normal)
        institutionalButton.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        institutionalButton.layer.cornerRadius = 20
        institutionalButton.addTarget(self, action: #selector(institutionalButtonClicked), for: .touchUpInside)
        view.addSubview(institutionalButton)
        
        let screenWidth = UIScreen.main.bounds.width
        //let screenHeight = UIScreen.main.bounds.height
        
        let buttonWidth : CGFloat = min(screenWidth - 40, 300)
        let buttonHeight : CGFloat = 50
        let spacing: CGFloat = 20

        
        individualButton.translatesAutoresizingMaskIntoConstraints = false
        institutionalButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            // Buton 1 konum ve boyutu
            individualButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            individualButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            individualButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            individualButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -buttonHeight - spacing / 2),

            institutionalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            institutionalButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            institutionalButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            institutionalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonHeight + spacing / 2),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor , constant: -200),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8 )
                ])
        
        
    }
    
    @objc func individualButtonClicked(){
        performSegue(withIdentifier: "toSignInSegue", sender: nil)
        
    }
    @objc func institutionalButtonClicked(){
        print("institutionalButtonClicked")
        performSegue(withIdentifier: "toInstitutionalSegue", sender: nil)

    }
    

}
