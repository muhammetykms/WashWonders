import UIKit

class HomeCardCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white // Set the background color if needed
        view.layer.cornerRadius = 8 // Round the corners if desired
        view.layer.borderWidth = 1 // Add border width if desired
        view.layer.borderColor = UIColor.red.cgColor // Set border color if desired
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    // Create location icon image view
    let locationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "locationIcon") // Set your icon name here
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 107/255, green: 114/255, blue: 128/255, alpha: 1.0)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Create icon image view
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "openHoursIcon") // Set your icon name here
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Create and configure "Açılış Saati" label
    let openingHoursTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Açılış Saati"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 107/255, green: 114/255, blue: 128/255, alpha: 1.0)
        return label
    }()
    
    let openingHoursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // Create contact icon image view
    let contactIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "contactIcon") // Set your icon name here
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let detailButtonStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.alignment = .fill
        stackView.distribution = .fillEqually // Değişiklik burada
        return stackView
    }()

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {

        // Add the container view to the cell
        contentView.addSubview(containerView)
        
        // Add subviews to the container view
        containerView.addSubview(titleLabel)
        containerView.addSubview(locationLabel)
        containerView.addSubview(imageView)
        containerView.addSubview(openingHoursLabel)
        containerView.addSubview(openingHoursTitleLabel)
        containerView.addSubview(contactButton)
        containerView.addSubview(iconImageView)
        containerView.addSubview(locationIconImageView)
        containerView.addSubview(contactIconImageView)
        
        // Set up constraints for the container view
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Set up constraints for subviews inside the container view
        NSLayoutConstraint.activate([
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            // locationIconImageView constraints
            locationIconImageView.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            locationIconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            locationIconImageView.widthAnchor.constraint(equalToConstant: 16),
            locationIconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            // locationLabel constraints
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: locationIconImageView.trailingAnchor, constant: 6),
            locationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            // imageView constraints
            imageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 185),
            
            openingHoursTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            openingHoursTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 6),
            openingHoursTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            // openingHoursLabel constraints
            openingHoursLabel.topAnchor.constraint(equalTo: openingHoursTitleLabel.bottomAnchor, constant: 8),
            openingHoursLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            openingHoursLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            // Icon ImageView constraints
            iconImageView.centerYAnchor.constraint(equalTo: openingHoursTitleLabel.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            // contactIconImageView constraints
            contactIconImageView.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor),
            contactIconImageView.leadingAnchor.constraint(equalTo: contactButton.leadingAnchor, constant: -30),
            contactIconImageView.widthAnchor.constraint(equalToConstant: 20),
            contactIconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // contactButton constraints
            contactButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28),
            contactButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            contactButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    }



