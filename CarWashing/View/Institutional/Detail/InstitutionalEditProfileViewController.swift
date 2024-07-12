import UIKit
import FirebaseAuth
import FirebaseFirestore

class InstitutionalEditProfileViewController: UIViewController {
    
    // MARK: - Properties
    var institutionalUserViewModel: InstitutionalUserViewModel!
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let companyNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şirket adı"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Adres"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let capacityCountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Capacity Count"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: CGFloat(96) / 255.0,
                                       green: CGFloat(82) / 255.0,
                                       blue: CGFloat(180) / 255.0,
                                       alpha: 1.0)
        
        /*institutionalUserViewModel = InstitutionalUserViewModel()
        institutionalUserViewModel.bindUserViewModelToController = {
            self.updateUI()
        }
        
        institutionalUserViewModel.fetchUsersData()*/
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
        
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerView.addSubview(companyNameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(addressTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(capacityCountTextField)
        //containerView.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            companyNameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            companyNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            companyNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: companyNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            addressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            capacityCountTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            capacityCountTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            capacityCountTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        
        let updateButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Güncelle", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(updateProfile), for: .touchUpInside)
            return button
        }()
        
        NSLayoutConstraint.activate([
            updateButton.topAnchor.constraint(equalTo: capacityCountTextField.bottomAnchor, constant: 20),
            updateButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    // MARK: - Update UI
    
    func updateUI() {
        guard let user = institutionalUserViewModel.institutionalUsers.first else { return }
        
        DispatchQueue.main.async {
            self.companyNameTextField.text = user.companyName
            self.emailTextField.text = user.email
            self.addressTextField.text = user.address
            self.passwordTextField.text = user.password
            self.capacityCountTextField.text = String(user.capacityCount)
            
            if let profileImageURL = URL(string: user.profileImage) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: profileImageURL) {
                        DispatchQueue.main.async {
                            
                            if let image = UIImage(data: data) {
                                self.profileImageView.image = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func updateProfile() {
        guard let user = institutionalUserViewModel.institutionalUsers.first else { return }
        
        let updatedUser = InstitutionalUserModel(dictionary: [
            "CompanyName": companyNameTextField.text ?? "",
            "Address": addressTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "password": passwordTextField.text ?? "",
            "profileImageUrl": user.profileImage,
            "CapacityCount": Int(capacityCountTextField.text ?? "0") ?? 0
        ])
        
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID not found")
            return
        }
        
        /*let docRef = db.collection("users").document(userID).collection("kurumsal").document("kullaniciBilgileri")
         docRef.setData(updatedUser.toDictionary()) { error in
         if let error = error {
         print("Error updating document: \(error.localizedDescription)")
         } else {
         print("Document successfully updated")
         }
         }
         }*/
    }
}
