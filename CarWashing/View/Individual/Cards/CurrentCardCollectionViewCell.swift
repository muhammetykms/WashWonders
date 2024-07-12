import UIKit

class CurrentCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 139/255, green: 117/255, blue: 180/255, alpha: 1)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Detay", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dayTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = UIColor(red: 228/255, green: 44/255, blue: 95/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.clear.cgColor
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(detailButton)
        containerView.addSubview(dayTitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            detailButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            detailButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            dayTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            dayTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }
}
