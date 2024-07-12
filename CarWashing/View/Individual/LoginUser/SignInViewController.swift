//
//  SignInViewController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 8.04.2024.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController , UITextFieldDelegate {
    
    
    
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
    let backgroundImage: UIImageView = {
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
    
    let emailTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Mail Giriniz...")
        return textField
    }()
    /*
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
    }()*/
    
    let passwordTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Şifre Giriniz...", isSecureTextEntry: true)
        return textField
    }()
    
    /*
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şifre Giriniz..."
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1.1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()*/
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Şifreni mi unuttun ?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kayıt Ol", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    /*let googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.setTitle("Google ile Giriş Yap", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(googleLoginButtonClicked), for: .touchUpInside)
        //button.contentHorizontalAlignment = .left // Yatay hizalama sağa
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0) // Yazıyı 10 birim sağa kaydırma
        
        return button
    }()*/
    
    let signInButton : CustomButton = {
        let button = CustomButton(setTitle: "Giriş Yap")
        button.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return button
    }()
    
    /*
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş Yap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return button
    }()*/
    
    /*let googleButtonImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "googleIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        return imageView
    }()*/
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var tapGestureRecognizer :  UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        return tapGestureRecognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        //navigationItem.hidesBackButton = true // Geri butonunu gizlemek için ekleyin

        
        // Klavye gösterilme ve gizlenme olaylarını dinlemek için bildirimlere abone olunuyor
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    func setupUI() {
        // Add components to view
        navigationItem.hidesBackButton = false
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        view.addGestureRecognizer(tapGestureRecognizer)
        scrollView.addSubview(stackView)
        stackView.addSubview(buttonStackView)
        stackView.addSubview(titleLabel)
        stackView.addSubview(emailTextField)
        stackView.addSubview(passwordTextField)
        stackView.addSubview(forgotPasswordButton)
        stackView.addSubview(signUpButton)
        //googleLoginButton.addSubview(googleButtonImageView)
        //stackView.addSubview(googleLoginButton)
        stackView.addSubview(signInButton)
        // Add buttons to buttonStackView
        buttonStackView.addArrangedSubview(forgotPasswordButton)
        buttonStackView.addArrangedSubview(signUpButton)
      
        
        
        
        // Başlık metnini renklendirme
        let attributedText = NSMutableAttributedString(string: "Wash", attributes: [NSAttributedString.Key.backgroundColor: UIColor.blue])
        attributedText.append(NSAttributedString(string: "Wonders", attributes: [NSAttributedString.Key.backgroundColor: UIColor.yellow]))
        titleLabel.attributedText = attributedText
        // Set up constraints
        setupConstraints()
    }
    
    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        //googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        //googleButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // ScrollView constraints
                    scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // Uygulama ekranının üst kısmından başlayacak
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    
                    // StackView constraints
                    stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                    // StackView içindeki en alt view'in alt kısmının scrollView'un alt kısmına eşitlenmesi
                    stackView.bottomAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            
            titleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 150),
            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            emailTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenHeight * 0.1),
            emailTextField.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: screenHeight * 0.1),
            signInButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            /*googleLoginButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            googleLoginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            googleLoginButton.widthAnchor.constraint(equalToConstant: screenWidth * 0.6),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 50),
            
            googleButtonImageView.leadingAnchor.constraint(equalTo: googleLoginButton.leadingAnchor, constant: 5),
            googleButtonImageView.centerYAnchor.constraint(equalTo: googleLoginButton.centerYAnchor),
            googleButtonImageView.widthAnchor.constraint(equalToConstant: 40),
            googleButtonImageView.heightAnchor.constraint(equalToConstant: 40),*/
            
            buttonStackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3),
            buttonStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func signInButtonClicked() {
        
        //Uygulama İçin şuan giriş kontrolleri kapalı
        if emailTextField.text! != "" && passwordTextField.text! != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                }else{
                    self.performSegue(withIdentifier: "toTabBarSegue", sender: nil)

                }
            }
        }else{
            makeAlert(titleInput: "Hata", messageInput: "Mail/Şifre")
        }
    }
    
    @objc func googleLoginButtonClicked() {
        print("Google Button Tıklandı")
    }
    
    @objc func forgotPasswordButtonClicked() {
        performSegue(withIdentifier: "toForgotPasswordSegue", sender: nil)
    }
    
    @objc func signUpButtonClicked() {
        performSegue(withIdentifier: "toSignUpSegue", sender: nil)
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
