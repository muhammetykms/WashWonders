//
//  PrivacyViewController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 21.04.2024.
//

import UIKit

class PrivacyViewController: UIViewController {

    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gizlilik Politikası"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let privacyTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        CarWashing olarak, gizliliğinizi koruma konusunda kararlıyız. Kişisel bilgilerinizi toplarken ve kullanırken, en yüksek güvenlik ve gizlilik standartlarına uymaktayız. Gizlilik politikamız, sizinle ilgili hangi bilgileri topladığımızı, bu bilgileri nasıl kullandığımızı ve koruduğumuzu açıklamaktadır.

        Topladığımız Bilgiler:
        - Adınız, e-posta adresiniz, telefon numaranız ve adresiniz gibi kişisel bilgiler.
        - Hizmetlerimizi kullanırken sağladığınız bilgiler ve geri bildirimler.

        Bilgilerin Kullanımı:
        - Hizmetlerimizi sunmak ve geliştirmek.
        - İletişim kurmak ve müşteri desteği sağlamak.
        - Yasal gerekliliklere uymak.

        Bilgilerin Korunması:
        - Kişisel bilgilerinizi yetkisiz erişim, değişiklik, ifşa veya imhaya karşı korumak için çeşitli güvenlik önlemleri uygularız.
        - Bilgilerinizi sadece gerekli olan süre boyunca saklarız ve yasal gerekliliklere uygun olarak imha ederiz.

        CarWashing olarak, gizliliğinize saygı duyar ve bilgilerinizin güvenliğini sağlamak için çaba gösteririz. Gizlilik politikamızla ilgili sorularınız için lütfen bizimle iletişime geçin.
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
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
        containerView.addSubview(privacyTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            privacyTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            privacyTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            privacyTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            privacyTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}
