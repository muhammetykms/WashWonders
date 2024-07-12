import UIKit

class Card: UIView {
    
    // MARK: - Properties
    
    let data: CardData
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Özelliklerini ayarla (font, renk, vs.)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Özelliklerini ayarla (font, renk, vs.)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // Özelliklerini ayarla (content mode, vs.)
        return imageView
    }()
    
    let openingHoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Özelliklerini ayarla (font, renk, vs.)
        return label
    }()
    
    let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        // Özelliklerini ayarla (title, target-action, vs.)
        return button
    }()
    
    // MARK: - Initialization
    
    init(data: CardData) {
        self.data = data
        super.init(frame: .zero)
        
        setupViews()
        setupData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        // Kart görünümünün genel ayarları
        
        // Alt öğeleri kart görünümüne ekle
        addSubview(titleLabel)
        addSubview(locationLabel)
        addSubview(imageView)
        addSubview(openingHoursLabel)
        addSubview(contactButton)
        
        // Alt öğelerin konumlarını ayarla
        NSLayoutConstraint.activate([
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // locationLabel constraints
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // imageView constraints
            imageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 200), // Örnek bir boyut
            
            // openingHoursLabel constraints
            openingHoursLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            openingHoursLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            openingHoursLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // contactButton constraints
            contactButton.topAnchor.constraint(equalTo: openingHoursLabel.bottomAnchor, constant: 8),
            contactButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            contactButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            contactButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setupData() {
        // Veriden kart öğelerini ayarla
        titleLabel.text = data.title
        locationLabel.text = data.location
        // Burada bir placeholder image ayarlayabilirsiniz, çünkü CardData'da bir image özelliği yok.
        imageView.image = UIImage(named: "placeholder")
        openingHoursLabel.text = data.openingHours
        contactButton.setTitle(data.contactButtonText, for: .normal)
    }
}
