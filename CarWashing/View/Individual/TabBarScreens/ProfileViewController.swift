import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    var settingsData: [String] = ["Profili Düzenle", "Hakkımda", "Gizlilik", "Güvenlik", "Çıkış Yap"]
    var notificationSwitch: UISwitch!
    var darkModeSwitch: UISwitch!
    var userViewModel = UserViewModel()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Ayarlar"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "settingsIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: CGFloat(96) / 255.0, green: CGFloat(82) / 255.0, blue: CGFloat(180) / 255.0, alpha: 1.0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        userViewModel.bindUserToController = {
            self.updateUI()
        }

        userViewModel.individualFetchUserDetails()
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
        
        view.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconImageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20)
        ])
        
        view.addSubview(settingsLabel)
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            settingsLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            settingsLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        containerView.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        tableView.clipsToBounds = true
        tableView.layer.borderWidth = 1.1
        tableView.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = settingsData[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            editProfile()
        case 1:
            about()
        case 2:
            privacy()
        case 3:
            security()
        case 4:
            logout()
        default:
            break
        }
    }
    
    // MARK: - Update UI
       private func updateUI() {
           guard let user = userViewModel.user else {
               print("No user found")
               return
           }
           
           DispatchQueue.main.async {
               self.nameLabel.text = "\(user.name) \(user.surname)"
           }
           
           // URL'den veri indirme işlemini URLSession kullanarak yap
           if let profileImageURL = URL(string: user.profileImageUrl) {
               let task = URLSession.shared.dataTask(with: profileImageURL) { data, response, error in
                   if let error = error {
                       print("Error fetching image: \(error)")
                       return
                   }
                   
                   guard let data = data, let image = UIImage(data: data) else {
                       print("Failed to fetch data from URL or convert data to image")
                       return
                   }
                   
                   // UI güncellemelerini ana thread'de yap
                   DispatchQueue.main.async {
                       self.profileImageView.image = image
                   }
               }
               task.resume()
           }
       }
   


    // MARK: - Actions
    @objc func notificationSwitchChanged(_ sender: UISwitch) {
        // Handle notification switch change
    }
    
    @objc func darkModeSwitchChanged(_ sender: UISwitch) {
        // Handle dark mode switch change
    }
    
    @objc func signInButtonClicked() {
        print("Butona Tıklandı")
    }
    
    private func editProfile() {
        performSegue(withIdentifier: "toEditProfileSegue", sender: nil)
    }
    
    private func about() {
        performSegue(withIdentifier: "toAboutSegue", sender: nil)
    }
    
    private func privacy() {
        performSegue(withIdentifier: "toPrivacySegue", sender: nil)
    }
    
    private func security() {
        performSegue(withIdentifier: "toSecuritySegue", sender: nil)
    }
    
    private func logout() {
        performSegue(withIdentifier: "toInstitutionalEditProfileSegue", sender: nil)
    }
}
