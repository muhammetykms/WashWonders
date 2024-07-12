import UIKit

class CurrentAppointmentViewController: UIViewController {
    
    // MARK: - Properties
    private var institutionalAppointmentViewModel = InstitutionalAppointmentViewModel()
    private var collectionView: UICollectionView!
    private var refreshControl: UIRefreshControl!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.topItem?.title = "Randevu Bilgileri"
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: CGFloat(96) / 255.0, green: CGFloat(82) / 255.0, blue: CGFloat(180) / 255.0, alpha: 1.0)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        
        setupCollectionView()
        setupRefreshControl()
        bindViewModel()
        institutionalAppointmentViewModel.fetchIndividualUserAppointments()  // Bireysel kullanıcı randevularını fetch et
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CurrentCardCollectionViewCell.self, forCellWithReuseIdentifier: "CurrentCardCell")
        
        view.addSubview(collectionView)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    private func bindViewModel() {
        institutionalAppointmentViewModel.bindAppointmentsToController = { [weak self] in
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshData() {
        institutionalAppointmentViewModel.fetchIndividualUserAppointments()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrentAppoinmentDetailSegue",
           let destinationVC = segue.destination as? CurrentAppointmentDetailViewController,
           let appointment = sender as? InstitutionalAppointmentModel {
            destinationVC.serviceTitle = appointment.companyName
            destinationVC.imageURL = appointment.companyProfileImageUrl
            destinationVC.appointmentDate = appointment.date
            destinationVC.appointmentTime = appointment.selectedTime
            destinationVC.cleaningType = appointment.selectedService
            destinationVC.userName = "\(appointment.name) \(appointment.surname)"
            destinationVC.appointmentId = appointment.appointmentId

            if let valetServiceValue = appointment.valeService as? Bool {
                destinationVC.valetService = valetServiceValue ? "Var" : "Yok"
            } else if let valetServiceValue = appointment.valeService as? String {
                destinationVC.valetService = (valetServiceValue.lowercased() == "evet" || valetServiceValue.lowercased() == "true") ? "Var" : "Yok"
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CurrentAppointmentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return institutionalAppointmentViewModel.appointments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentCardCell", for: indexPath) as! CurrentCardCollectionViewCell
        
        let appointment = institutionalAppointmentViewModel.appointments[indexPath.item]
        
        cell.titleLabel.text = appointment.companyName
        cell.dayTitleLabel.text = "\(appointment.date) \(appointment.selectedTime)"
        
        cell.detailButton.addTarget(self, action: #selector(detailButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func detailButtonTapped(_ sender: UIButton) {
        let appointment = institutionalAppointmentViewModel.appointments[sender.tag]
        performSegue(withIdentifier: "toCurrentAppoinmentDetailSegue", sender: appointment)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CurrentAppointmentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
