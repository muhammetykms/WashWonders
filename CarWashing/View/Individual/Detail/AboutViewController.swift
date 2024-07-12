//
//  AboutViewController.swift
//  CarWashing
//
//  Created by Muhammet Yıkmış on 21.04.2024.
//

import UIKit

class AboutViewController: UIViewController {

    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Şirketimiz"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let aboutTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        CarWashing'e hoş geldiniz, araç bakımı ve yıkama konusunda bir numaralı tercihiniz. Yılların tecrübesi ve kaliteye olan sarsılmaz bağlılığımızla, aracınızı en iyi durumda tutmak için üstün hizmetler sunmaktan gurur duyuyoruz. Misyonumuz, piyasadaki en iyi ürün ve teknikleri kullanarak üstün bir araç yıkama hizmeti sağlamaktır.

        CarWashing'de, müşteri memnuniyetini her şeyin üzerinde tutuyoruz ve her ziyarette beklentilerinizi aşmak için çabalıyoruz. Aracınızın bakımında bize güvendiğiniz için teşekkür ederiz!
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
        containerView.addSubview(aboutTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            aboutTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            aboutTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            aboutTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            aboutTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}

