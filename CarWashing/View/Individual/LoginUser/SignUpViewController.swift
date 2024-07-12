//
//  SignUpViewController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 8.04.2024.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController , UITextFieldDelegate{
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true // Bu satırı ekleyin
        return scrollView
    }()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    
    //  Background
    let backgroundImage : UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Components
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "WashWonders"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    let nameTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "İsim Giriniz...")
        return textField
    }()
  
    let lastNameTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Soyisim Giriniz...")
        return textField
    }()

    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Mail Giriniz...")
        return textField
    }()
    


    
    let passwordTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Şifre Giriniz..." , isSecureTextEntry: true)
        return textField
    }()
       
    let confirmPasswordTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Tekrar Şifre Giriniz...")
        return textField
    }()
   

    
    let signUpButton : CustomButton = {
        let button = CustomButton(setTitle: "Kayıt Ol")
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    

    
    lazy var tapGestureRecognizer : UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        return tapGestureRecognizer
    }()
    
    func setupUI(){


        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addGestureRecognizer(tapGestureRecognizer)
        
        stackView.addSubview(titleLabel)
        stackView.addSubview(nameTextField)
        stackView.addSubview(lastNameTextField)
        stackView.addSubview(emailTextField)
        stackView.addSubview(passwordTextField)
        stackView.addSubview(confirmPasswordTextField)
        stackView.addSubview(signUpButton)
        
        
        
        // Başlık metnini renklendirme
        let attributedText = NSMutableAttributedString(string: "Wash", attributes: [NSAttributedString.Key.backgroundColor: UIColor.blue])
        attributedText.append(NSAttributedString(string: "Wonders", attributes: [NSAttributedString.Key.backgroundColor: UIColor.yellow]))
        titleLabel.attributedText = attributedText
        
        setupConstraints()


    }

    func setupConstraints(){
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        

        
        NSLayoutConstraint.activate([
            // Background image constraints

            
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                //contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, multiplier : 1.1), // ContentView'in boyutu ScrollView'un boyutunu aşmamalı

            
            // Title Label constraints
            titleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 150),
            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            // Name Text Field constraints
            nameTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenHeight * 0.1),
            nameTextField.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Last Name Text Field
            lastNameTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            lastNameTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Email Text Field
            emailTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password Text Field
            passwordTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Confirm Password Text Field
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Sign Up Button
            signUpButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -screenHeight * 0.1) // Yeni constraint ekledim
        ])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // TextField'ların delegate'leri ayarlanıyor
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        
        // Klavye gösterilme ve gizlenme olaylarını dinlemek için bildirimlere abone olunuyor
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func signUpButtonClicked(){
        
        guard let name = nameTextField.text,
              let lastname = lastNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
        let confirmPassword = confirmPasswordTextField.text
        else{
            return
        }
        
        if name.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty{
            makeAlert(titleInput: "Hata", messageInput: "Lütfen bütün kutucukları doldurunuz!")
            return
        }
        
        if password != confirmPassword {
            
            makeAlert(titleInput: "Hata", messageInput: "Şifreler Uyuşmuyor!")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authdata, error in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription)
            }else{
                self.performSegue(withIdentifier: "toTabBarSegue", sender: nil)
            }
        }
    }
    
    func makeAlert (titleInput:String , messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // TextField'a dokunulduğunda çağrılacak fonksiyon
        func textFieldDidBeginEditing(_ textField: UITextField) {
            // TextField'ın üst kısmı klavyenin altına gelecek şekilde ScrollView'ı yukarı kaydır
            if let frame = textField.superview?.convert(textField.frame, to: scrollView) {
                scrollView.scrollRectToVisible(frame, animated: true)
            }
        }
        
        // Klavye gösterildiğinde çağrılacak fonksiyon
        @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            }
        }
        
        // Klavye gizlendiğinde çağrılacak fonksiyon
        @objc func keyboardWillHide(notification: NSNotification) {
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    
    @objc func handleTap (){
        view.endEditing(true)
    }
    
    
    

}
