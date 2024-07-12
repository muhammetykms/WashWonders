import UIKit
import SDWebImage
import FirebaseFirestore
import FirebaseAuth

class CurrentAppointmentDetailViewController: UIViewController {

    // MARK: - Properties
    var serviceTitle: String?
    var imageURL: String?
    var appointmentDate: String?
    var appointmentTime: String?
    var cleaningType: String?
    var userName: String?
    var valetService: String?
    var appointmentId: String? // Add this to identify the appointment in the database
    
    // MARK: - UI Components
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let serviceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let appointmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cleaningTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valetServiceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İptal Et", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelAppointment), for: .touchUpInside)
        return button
    }()
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tamamlandı", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(completeAppointment), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        setupUI()
        
        
        
        
        if let serviceTitle = serviceTitle {
            let attributedString = NSMutableAttributedString(
                string: "İşletme: ",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)]
            )
            attributedString.append(NSAttributedString(
                string: serviceTitle,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor.black]
            ))
            serviceLabel.attributedText = attributedString
        }
        
        if let imageURL = imageURL {
            print("imageURL : \(imageURL)")
            imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "osmaniyeOtoYıkama"))
        }
        
        if let appointmentDate = appointmentDate, let appointmentTime = appointmentTime {
            let attributedString = NSMutableAttributedString(
                string: "Randevu Saati: ",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)]
            )
            attributedString.append(NSAttributedString(
                string: "\(appointmentDate), \(appointmentTime)",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor.black]
            ))
            appointmentLabel.attributedText = attributedString
        }
        
        if let cleaningType = cleaningType {
            let attributedString = NSMutableAttributedString(
                string: "Temizlik Türü: ",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)]
            )
            attributedString.append(NSAttributedString(
                string: cleaningType,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor.black]
            ))
            cleaningTypeLabel.attributedText = attributedString
        }
        
        if let userName = userName {
            let attributedString = NSMutableAttributedString(
                string: "Ad-Soyad: ",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)]
            )
            attributedString.append(NSAttributedString(
                string: userName,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor.black]
            ))
            userNameLabel.attributedText = attributedString
        }
        
        if let valetService = valetService {
            let attributedString = NSMutableAttributedString(
                string: "Vale Hizmeti: ",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)]
            )
            attributedString.append(NSAttributedString(
                string: valetService,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor.black]
            ))
            valetServiceLabel.attributedText = attributedString
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        view.backgroundColor = UIColor(red: CGFloat(96) / 255.0, green: CGFloat(82) / 255.0, blue: CGFloat(180) / 255.0, alpha: 1.0)
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 0
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 1.1
        containerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(containerView)
        
        view.addSubview(imageView)
        containerView.addSubview(serviceLabel)
        containerView.addSubview(appointmentLabel)
        containerView.addSubview(cleaningTypeLabel)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(valetServiceLabel)
        containerView.addSubview(cancelButton)
        containerView.addSubview(completeButton)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 500),
            
            imageView.centerXAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 150),
            imageView.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 80),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -67.5),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 135),
            
            serviceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            serviceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            serviceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            appointmentLabel.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor, constant: 30),
            appointmentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            appointmentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            cleaningTypeLabel.topAnchor.constraint(equalTo: appointmentLabel.bottomAnchor, constant: 30),
            cleaningTypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cleaningTypeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            userNameLabel.topAnchor.constraint(equalTo: cleaningTypeLabel.bottomAnchor, constant: 30),
            userNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            valetServiceLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30),
            valetServiceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            valetServiceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -10),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            completeButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            completeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            completeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    @objc private func cancelAppointment() {
        guard let appointmentId = appointmentId else {
            print("Appointment ID not found")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("randevular").document(appointmentId).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
                if let navigationController = self.navigationController {
                    navigationController.popToRootViewController(animated: true)
                } else {
                    // Eğer navigation controller yoksa, manuel olarak HomeViewController'a geçiş yapabilirsiniz
                    let currentVC = CurrentAppointmentViewController()
                    currentVC.modalPresentationStyle = .fullScreen
                    self.present(currentVC, animated: true, completion: nil)
                }
            }
        }
    }

    @objc private func completeAppointment() {
        guard let appointmentId = appointmentId else {
            print("Appointment ID not found")
            return
        }

        let db = Firestore.firestore()
        let currentAppointmentRef = db.collection("randevular").document(appointmentId)
        
        currentAppointmentRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                db.collection("gecmisRandevular").document(appointmentId).setData(data ?? [:]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        currentAppointmentRef.delete { error in
                            if let error = error {
                                print("Error removing document: \(error)")
                            } else {
                                print("Document successfully moved to gecmisRandevular!")
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
