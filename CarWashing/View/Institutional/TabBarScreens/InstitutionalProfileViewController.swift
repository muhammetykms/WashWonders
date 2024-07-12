import UIKit
import FirebaseAuth

class InstitutionalProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var userViewModel = UserViewModel()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail // Metni kesmek için
        return label
    }()
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Ayarlar"
        label.textColor = .white // Yazının rengi beyaz olarak ayarlandı
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Icon image'i oluşturun
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // İmajın içeriğe sığacak şekilde boyutlanması sağlanır
        imageView.image = UIImage(named: "settingsIcon") // İcon resmi yüklenir, "iconName" yerine gerçek dosya adını kullanın
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    
    let options = ["Profili Düzenle", "Hakkımızda", "Gizlilik", "Güvenlik", "Çıkış Yap"]
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: CGFloat(96) / 255.0,
                                        green: CGFloat(82) / 255.0,
                                        blue: CGFloat(180) / 255.0,
                                        alpha: 1.0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        userViewModel.bindCorporateUserToController = {
            self.updateUI()
        }
        
        userViewModel.corporateFetchUserDetails()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {

        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 20 // Köşe yuvarlaklığı ekleyelim
        containerView.clipsToBounds = true // TableView'ın köşelerinin içeriğe uymasını sağlayalım
        containerView.layer.borderWidth = 1.1
        containerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(containerView)
        
        // IconImageView'i containerView'a ekleyin
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
        
        containerView.addSubview(companyNameLabel)
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            companyNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            companyNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            companyNameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // TableView'a corner radius ekleyelim
        tableView.clipsToBounds = true
        tableView.layer.borderWidth = 1.1
        tableView.layer.borderColor = UIColor.black.cgColor
    }

    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Seçilen seçenekle ilgili işlemler burada gerçekleştirilebilir
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
    
    
    func updateUI() {
        guard let user = userViewModel.corporateUser else { return }
        
        DispatchQueue.main.async {
            self.companyNameLabel.text = user.companyName
            
            if let profileImageURL = URL(string: user.profileImage) {
                URLSession.shared.dataTask(with: profileImageURL) { data, response, error in
                    if let error = error {
                        print("Failed to fetch data from URL: \(error)")
                        return
                    }
                    
                    guard let data = data, let image = UIImage(data: data) else {
                        print("Failed to convert data to image")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }.resume()
            }
        }
    }

    
    // MARK: - Actions
    
    private func editProfile() {
        // Profili düzenleme işlemleri
        performSegue(withIdentifier: "toInstitutionalEditProfileSegue", sender: nil)
    }
    
    private func about() {
        // Hakkımda
        performSegue(withIdentifier: "toInstitutionalAboutSegue", sender: nil)
    }
    
    private func privacy() {
        // Gizlilik işlemleri
        performSegue(withIdentifier: "toInstitutionalPrivacySegue", sender: nil)
    }
    
    private func security() {
        // Güvenlik işlemleri
        performSegue(withIdentifier: "toInstitutionalSecuritySegue", sender: nil)
    }
    
    private func logout() {
        // Çıkış yapma işlemleri
    }
    
    
    private func calculateCombinedColor() -> UIColor {
        let yellow: (red: CGFloat, green: CGFloat, blue: CGFloat) = (255, 204, 0)
        let blueishPurple: (red: CGFloat, green: CGFloat, blue: CGFloat) = (51, 48, 229)
        
        let yellowPercentage = 0.20 // %20
        let blueishPurplePercentage = 0.90 // %90
        
        let combinedRed = (yellow.red * yellowPercentage) + (blueishPurple.red * blueishPurplePercentage)
        let combinedGreen = (yellow.green * yellowPercentage) + (blueishPurple.green * blueishPurplePercentage)
        let combinedBlue = (yellow.blue * yellowPercentage) + (blueishPurple.blue * blueishPurplePercentage)
        
        let totalPercentage = yellowPercentage + blueishPurplePercentage
        
        let finalRed = combinedRed / totalPercentage
        let finalGreen = combinedGreen / totalPercentage
        let finalBlue = combinedBlue / totalPercentage
        
        return UIColor(red: finalRed / 255, green: finalGreen / 255, blue: finalBlue / 255, alpha: 1.0)
    }
}
