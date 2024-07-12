import UIKit
import FirebaseFirestore
import FirebaseAuth

class InstitutionalHomeViewController: UIViewController {
    var institutionalCardData: [InstitutionalCardData] = []
    var appointmentViewModel = InstitutionalAppointmentViewModel()
    // Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "WashWonders"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    /*let topRightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return imageView
    }()*/
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .white
        searchBar.tintColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        return searchBar
    }()
    
    // Collection view
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InstitutionalHomeCardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleLabel
        //let rightBarButton = UIBarButtonItem(customView: topRightImageView)
        //navigationItem.rightBarButtonItem = rightBarButton
        
        setupUI()
        setupBindings()
        print("Fetching appointments in viewDidLoad...")
        appointmentViewModel.fetchAppointments()
    }
    
    func setupUI() {
        navigationItem.hidesBackButton = true
        view.addSubview(titleLabel)
        //view.addSubview(topRightImageView)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        let attributedText = NSMutableAttributedString(string: "Wash", attributes: [NSAttributedString.Key.backgroundColor: UIColor.blue])
        attributedText.append(NSAttributedString(string: "Wonders", attributes: [NSAttributedString.Key.backgroundColor: UIColor.yellow]))
        titleLabel.attributedText = attributedText
        
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //topRightImageView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            //topRightImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //topRightImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            //topRightImageView.widthAnchor.constraint(equalToConstant: 30),
            //topRightImageView.heightAnchor.constraint(equalToConstant: 30),
            
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.height * 0.02),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIScreen.main.bounds.height * 0.02),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupBindings() {
        appointmentViewModel.bindAppointmentsToController = { [weak self] in
            guard let self = self else { return }
            print("Appointments updated in viewModel, updating card data...")
            self.updateCardData()
            self.collectionView.reloadData()
        }
    }
    
    private func updateCardData() {
        institutionalCardData = appointmentViewModel.appointments.map { appointment in
            return InstitutionalCardData(
                title: "\(appointment.name) \(appointment.surname)",
                date: "Randevu Tarihi : \(appointment.date)",
                imageUrl: appointment.userProfileImageUrl,
                selectedTime: "Randevu Saati : \(appointment.selectedTime)",
                contactButtonText: "Detay Gör"
            )
        }
    }
}

extension InstitutionalHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in section: \(institutionalCardData.count)")
        return institutionalCardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! InstitutionalHomeCardCollectionViewCell
        cell.data = institutionalCardData[indexPath.item]
        print("Configuring cell at index \(indexPath.item) with data: \(institutionalCardData[indexPath.item])")
        
        return cell
    }
    
    // Implement size for item method for proper layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 150)
    }
}
