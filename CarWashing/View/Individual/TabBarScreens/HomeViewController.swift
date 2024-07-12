import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    private var institutionalUserViewModel = InstitutionalUserViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.topItem?.title = "Yıkama Şirketleri"
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: CGFloat(96) / 255.0, green: CGFloat(82) / 255.0, blue: CGFloat(180) / 255.0, alpha: 1.0)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        
        setupCollectionView()
        bindViewModel()
        institutionalUserViewModel.fetchCorporateData()
    }
    
    private func bindViewModel() {
        institutionalUserViewModel.bindUsersToController = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCardCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCardCell")
        view.addSubview(collectionView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomeContactSegue",
           let destinationVC = segue.destination as? HomeContactDetailViewController,
           let user = sender as? InstitutionalUserModel {
            destinationVC.serviceTitle = user.companyName
            destinationVC.imageURL = user.profileImage
            destinationVC.userID = user.id
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return institutionalUserViewModel.institutionalUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCardCell", for: indexPath) as! HomeCardCollectionViewCell
        
        let user = institutionalUserViewModel.institutionalUsers[indexPath.item]
        
        cell.titleLabel.text = user.companyName
        cell.imageView.sd_setImage(with: URL(string: user.profileImage ?? ""), placeholderImage: UIImage(named: "osmaniyeOtoYıkama"))
        cell.openingHoursLabel.text = "9:00 - 18:00"
        cell.locationLabel.text = user.address
        cell.contactButton.setTitle("İletişime Geç", for: .normal)
        cell.contactButton.tag = indexPath.item
        cell.contactButton.addTarget(self, action: #selector(detailButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        return CGSize(width: width, height: 350)
    }
    
    @objc func detailButtonTapped(_ sender: UIButton) {
        let user = institutionalUserViewModel.institutionalUsers[sender.tag]
        performSegue(withIdentifier: "toHomeContactSegue", sender: user)
    }
}
