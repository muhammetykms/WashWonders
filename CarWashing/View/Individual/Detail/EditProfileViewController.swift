import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditProfileViewController: UIViewController {

    // MARK: - Properties
    var userInformationViewModel: UserViewModel!
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Surname"
        textField.layer.borderWidth = 1.1
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.layer.borderWidth = 1.1
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Address"
        textField.layer.borderWidth = 1.1
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Güncelle", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(EditProfileViewController.self, action: #selector(updateProfile), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: CGFloat(96) / 255.0,
                                       green: CGFloat(82) / 255.0,
                                       blue: CGFloat(180) / 255.0,
                                       alpha: 1.0)
        
        userInformationViewModel = UserViewModel()
        userInformationViewModel.bindUserToController = {
            self.updateUI()
        }
        userInformationViewModel.individualFetchUserDetails()
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
        
        containerView.addSubview(nameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(lastNameTextField)
        containerView.addSubview(addressTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            addressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            updateButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            updateButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
    }
    
    // MARK: - Update UI
    
    func updateUI() {
        guard let user = userInformationViewModel.user else { return }
        
        DispatchQueue.main.async {
            self.nameTextField.text = user.name
            self.emailTextField.text = user.email
            self.lastNameTextField.text = user.surname
            self.passwordTextField.text = user.password
            self.addressTextField.text = user.address
            
            if let profileImageURL = URL(string: user.profileImageUrl) {
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
    
    //Bireysel kullanıcı bilgilerinin güncellenmesi kodları
    @objc private func updateProfile() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User ID not found")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("users").document(userId).collection("bireysel").document("kullaniciBilgileri")
        
        userDocRef.updateData([
            "name": nameTextField.text ?? "",
            "surname": lastNameTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "password": passwordTextField.text ?? "",
            "profileImageUrl": userInformationViewModel.user?.profileImageUrl ?? ""
        ]) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
