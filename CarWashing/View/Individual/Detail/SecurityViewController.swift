//
//  SecurityViewController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 21.04.2024.
//

import UIKit
import FirebaseAuth

class SecurityViewController: UIViewController {

    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hesap Güvenliği"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let resetPasswordTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        Şifre Sıfırlama:
        
        CarWashing hesabınızın şifresini sıfırlamak için aşağıdaki adımları takip edebilirsiniz:
        
        1. Giriş yap menüsünde 'Şifremi Unuttum' bağlantısına tıklayın.
        2. Açılan sayfada, hesabınızla ilişkili e-posta adresinizi girin.
        3. E-posta adresinize bir şifre sıfırlama bağlantısı gönderilecektir.
        4. E-postanıza gidin ve gelen bağlantıya tıklayarak yeni şifrenizi oluşturun.
        
        Şifrenizi sıfırlarken herhangi bir sorunla karşılaşırsanız, müşteri destek ekibimizle iletişime geçebilirsiniz.
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        //textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let accountSecurityTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        Hesap Güvenliği:
        
        Hesabınızın güvenliğini sağlamak için aşağıdaki önerilere dikkat edin:
        
        1. Güçlü bir şifre oluşturun ve düzenli olarak değiştirin.
        2. Hesap bilgilerinizin güvenliğini sağlamak için iki faktörlü kimlik doğrulama (2FA) kullanın.
        3. Şüpheli etkinlikler için hesabınızı düzenli olarak kontrol edin.
        4. Tanımadığınız veya güvenmediğiniz kişilerle hesap bilgilerinizi paylaşmayın.
        
        Hesabınızın güvenliği bizim için önemlidir. Güvenliğinizi artırmak için yukarıdaki adımları takip edin.
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        //textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: CGFloat(96) / 255.0,
                                       green: CGFloat(82) / 255.0,
                                       blue: CGFloat(180) / 255.0,
                                       alpha: 1.0)
    }

    // MARK: - UI Setup
    private func setupUI() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 1.1
        containerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(containerView)

        view.addSubview(titleLabel)
        containerView.addSubview(resetPasswordTextView)
        containerView.addSubview(accountSecurityTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            resetPasswordTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            resetPasswordTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            resetPasswordTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            accountSecurityTextView.topAnchor.constraint(equalTo: resetPasswordTextView.bottomAnchor, constant: 20),
            accountSecurityTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            accountSecurityTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            accountSecurityTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }

}
