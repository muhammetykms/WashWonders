import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseFirestore

class HomeContactDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // Dışarıdan gelen title ve image URL'sini tutmak için özellikler
    var serviceTitle: String?
    var imageURL: String?
    var userID: String?  // Add this line

    private var institutionalUserViewModel = InstitutionalUserViewModel()
    private var currentUser: User?
    private var userData: [String: Any]?
    
    // Firestore referansları
    private let db = Firestore.firestore()
    
    // MARK: - UI Components
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholderImage") // Placeholder image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let serviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Hizmet Adı"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serviceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Hizmet Seçiniz"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let servicePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let valetLabel: UILabel = {
        let label = UILabel()
        label.text = "Aracınızı vale hizmeti ile yıkatmak ister misiniz?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valetSwitch: UISwitch = {
        let valetSwitch = UISwitch()
        valetSwitch.isOn = false
        valetSwitch.translatesAutoresizingMaskIntoConstraints = false
        return valetSwitch
    }()
    
    let appointmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Randevu Saatleri"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeButtons: [UIButton] = {
        let times = ["10.00", "11.00", "12.00", "13.00", "14.00", "15.00", "16.00", "17.00", "18.00"]
        return times.map { time in
            let button = UIButton(type: .system)
            button.setTitle(time, for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Randevu oluştur", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let serviceOptions = ["İç-Dış Yıkama", "İç Yıkama", "Dış Yıkama"]
    
    var selectedTimeButton: UIButton?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Randevu Oluştur"
        setupUI()
        fetchCurrentUser()
        institutionalUserViewModel.fetchCorporateData()
        servicePicker.delegate = self
        servicePicker.dataSource = self
        serviceTextField.inputView = servicePicker
        setupTimeButtons()
        
        // Dışarıdan gelen title ve image URL'sini kullanarak UI'yı güncelle
        if let serviceTitle = serviceTitle {
            serviceLabel.text = serviceTitle
        }
        
        if let imageURL = imageURL {
            imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "osmaniyeOtoYıkama"))
        }
        
        createButton.addTarget(self, action: #selector(createAppointment), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(serviceLabel)
        view.addSubview(serviceTextField)
        view.addSubview(valetLabel)
        view.addSubview(valetSwitch)
        view.addSubview(appointmentLabel)
        timeButtons.forEach { view.addSubview($0) }
        view.addSubview(createButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            serviceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            serviceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            serviceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            serviceTextField.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor, constant: 20),
            serviceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            serviceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            valetLabel.topAnchor.constraint(equalTo: serviceTextField.bottomAnchor, constant: 20),
            valetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            valetSwitch.topAnchor.constraint(equalTo: valetLabel.bottomAnchor, constant: 10),
            valetSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            appointmentLabel.topAnchor.constraint(equalTo: valetSwitch.bottomAnchor, constant: 20),
            appointmentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appointmentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.heightAnchor.constraint(equalToConstant: 36),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18)
        ])
        
        let buttonWidth: CGFloat = 80
        let buttonHeight: CGFloat = 40
        let horizontalPadding: CGFloat = 20
        let verticalPadding: CGFloat = 20
        let interButtonSpacing: CGFloat = 20
        
        for (index, button) in timeButtons.enumerated() {
            let rowIndex = index / 4
            let columnIndex = index % 4
            let leadingAnchor = view.leadingAnchor
            let topAnchor = appointmentLabel.bottomAnchor
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(rowIndex) * (buttonHeight + verticalPadding) + verticalPadding),
                button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(columnIndex) * (buttonWidth + interButtonSpacing) + horizontalPadding),
                button.widthAnchor.constraint(equalToConstant: buttonWidth),
                button.heightAnchor.constraint(equalToConstant: buttonHeight)
            ])
        }
    }
    
    private func setupTimeButtons() {
        for button in timeButtons {
            button.addTarget(self, action: #selector(timeButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func timeButtonTapped(_ sender: UIButton) {
        // Tıklanan buton seçilmiş buton olarak ayarlanır
        if let selectedButton = selectedTimeButton {
            selectedButton.backgroundColor = .systemBlue
        }
        sender.backgroundColor = .systemGreen
        selectedTimeButton = sender
    }
    
    // MARK: - UIPickerViewDataSource and UIPickerViewDelegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serviceOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return serviceOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        serviceTextField.text = serviceOptions[row]
        view.endEditing(true)
    }
    
    // MARK: - Firestore Methods
    private func fetchCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.currentUser = user
            let userDocRef = db.collection("users").document(user.uid)
            userDocRef.collection("bireysel").document("kullaniciBilgileri").getDocument { (document, error) in
                if let document = document, document.exists {
                    self.userData = document.data()
                    if let userData = self.userData {
                        print("User Data: \(userData)")
                    }
                } else {
                    print("User document does not exist or there was an error: \(String(describing: error))")
                }
            }
        } else {
            print("No user is signed in")
        }
    }
    
    @objc private func createAppointment() {
        guard let user = currentUser,
              let service = serviceTextField.text,
              let timeButton = selectedTimeButton,
              let time = timeButton.titleLabel?.text,
              let userData = self.userData,
              let sellerId = userID else {  // Use userID directly
            print("Required fields are missing")
            return
        }
        
        let valetService = valetSwitch.isOn
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)

        let appointmentData: [String: Any] = [
            "companyName" : serviceTitle ?? "Şirket Adı",
            "companyProfileImageUrl" : imageURL ?? "test",
            "name": userData["name"] as? String ?? "",
            "surname": userData["surname"] as? String ?? "",
            "date": formattedDate,
            "selectedService": service,
            "selectedTime": time,
            "sellerId" : sellerId,  // Use sellerId here
            "userId": user.uid,
            "userProfileImageUrl": userData["profileImageUrl"] as? String ?? "",
            "valetService": valetService,
        ]
        
        db.collection("randevular").addDocument(data: appointmentData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
                if let navigationController = self.navigationController {
                    navigationController.popToRootViewController(animated: true)
                } else {
                    // Eğer navigation controller yoksa, manuel olarak HomeViewController'a geçiş yapabilirsiniz
                    let homeVC = HomeViewController()
                    homeVC.modalPresentationStyle = .fullScreen
                    self.present(homeVC, animated: true, completion: nil)
                }
            }
        }
    }
    
}
