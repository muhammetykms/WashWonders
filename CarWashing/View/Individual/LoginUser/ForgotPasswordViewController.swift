//
//  ForgotPasswordViewController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 8.04.2024.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    
    //  Background
    let backgroundImage : UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //  Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "WashWonders"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mail Giriniz..."
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1.1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Şifre Sıfırlama Bağlantısı Gönder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var tapGestureRecognizer : UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        return tapGestureRecognizer
    }()
    
    func setupUI() {
        // Add components to view
        
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(forgotPasswordButton)
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
        // Set up constraints
        setupConstraints()
        
        // Başlık metnini renklendirme
        let attributedText = NSMutableAttributedString(string: "Wash", attributes: [NSAttributedString.Key.backgroundColor: UIColor.blue])
        attributedText.append(NSAttributedString(string: "Wonders", attributes: [NSAttributedString.Key.backgroundColor: UIColor.yellow]))
        titleLabel.attributedText = attributedText
    }
    
    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenHeight * 0.1),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenHeight * 0.15),
            emailTextField.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: screenHeight * 0.1),
            forgotPasswordButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func forgotPasswordButtonClicked(){
        print("Şifre Sıfırla Tıklandı")
        
        guard let email = emailTextField.text, !email.isEmpty else{
            makeAlert(titleInput: "Hata", messageInput: "Lütfen e-posta adresinizi giriniz!")
            return
        }
        
        Auth.auth().fetchSignInMethods(forEmail: email) { signinMethods, error in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: "E-posta adresi kontrol edilirken bir hata oluştu. Lütfen tekrar deneyin")
                return
            }
            
            if let signInMethods = signinMethods, signInMethods.isEmpty{
                self.makeAlert(titleInput: "Hata", messageInput: "Girdiğiniz e-posta adresine kayıtlı bir kullanıcı bulunamadı")
            }
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toBackSignInSegue", sender: nil)
                    self.makeAlert(titleInput: "Başarılı", messageInput: "Şifre sıfırlama e-postası gönderildi. Lütfen gelen kutunuzu kontrol edin")
                }
            }
            
        }
     
    }
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
}
    
