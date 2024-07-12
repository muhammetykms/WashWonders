import UIKit
import SDWebImage
import FirebaseFirestore
import FirebaseAuth

class PastDetailViewController: UIViewController {

    // MARK: - Properties
    var serviceTitle: String?
    var imageURL: String?
    var appointmentDate: String?
    var appointmentTime: String?
    var cleaningType: String?
    var userName: String?
    var valetService: String?
    var appointmentId: String?
    
    let viewModel = InstitutionalAppointmentViewModel()
    
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        setupUI()
        fetchPastAppointmentDetails()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 139/255, green: 117/255, blue: 180/255, alpha: 1)
        
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
            valetServiceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Fetch Data
    private func fetchPastAppointmentDetails() {
        viewModel.fetchPastAppointments()
        viewModel.bindAppointmentsToController = { [weak self] in
            guard let self = self, let appointment = self.viewModel.appointments.first else { return }
            self.updateUI(with: appointment)
        }
    }
    
    private func updateUI(with appointment: InstitutionalAppointmentModel) {
        if let serviceTitle = appointment.companyName as String? {
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
        
        if let imageURL = appointment.companyProfileImageUrl as String? {
            imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholderImage"))
        }
        
        if let appointmentDate = appointment.date as String?, let appointmentTime = appointment.selectedTime as String? {
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
        
        if let cleaningType = appointment.selectedService as String? {
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
        
        if let userName = appointment.name as String? {
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
        
        if let valetService = appointment.valeService as Any? {
            let attributedString = NSMutableAttributedString(
                string: "Vale Hizmeti: ",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)]
            )
            let valetServiceString = (valetService as? Bool ?? false) ? "Var" : "Yok"
            attributedString.append(NSAttributedString(
                string: valetServiceString,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),
                             NSAttributedString.Key.foregroundColor: UIColor.black]
            ))
            valetServiceLabel.attributedText = attributedString
        }
    }
}
