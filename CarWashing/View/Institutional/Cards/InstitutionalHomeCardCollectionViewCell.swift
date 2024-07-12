import UIKit
import SDWebImage

class InstitutionalHomeCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var data: InstitutionalCardData? {
        didSet {
            setupData()
        }
    }
    
    // Container view to wrap the content
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 107/255, green: 114/255, blue: 128/255, alpha: 1.0)
        return label
    }()
    
    let selectedTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 107/255, green: 114/255, blue: 128/255, alpha: 1.0)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(selectedTimeLabel)
        containerView.addSubview(imageView)
        containerView.addSubview(contactButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            // imageView constraints
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            // dateLabel constraints
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            selectedTimeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            selectedTimeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            selectedTimeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            // contactButton constraints
            contactButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            contactButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
        ])
    }
    
    private func setupData() {
        guard let data = data else { return }
        titleLabel.text = data.title
        dateLabel.text = data.date
        contactButton.setTitle(data.contactButtonText, for: .normal)
        selectedTimeLabel.text = data.selectedTime
        imageView.sd_setImage(with: URL(string: data.imageUrl))
    }
}


    

