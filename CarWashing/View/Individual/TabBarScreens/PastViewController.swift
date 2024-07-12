import UIKit
import SDWebImage

class PastViewController: UIViewController {
    
    // MARK: - Properties
    private var pastAppointmentsViewModel = InstitutionalAppointmentViewModel()
    private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.topItem?.title = "Geçmiş Randevular"
        }
        setupCollectionView()
        bindViewModel()
        pastAppointmentsViewModel.fetchPastAppointments()
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PastCardCollectionViewCell.self, forCellWithReuseIdentifier: "PastCardCell")
        view.addSubview(collectionView)
    }
    
    private func bindViewModel() {
        pastAppointmentsViewModel.bindAppointmentsToController = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension PastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastAppointmentsViewModel.appointments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PastCardCell", for: indexPath) as! PastCardCollectionViewCell
        let appointment = pastAppointmentsViewModel.appointments[indexPath.item]
        cell.titleLabel.text = appointment.companyName
        cell.imageView.sd_setImage(with: URL(string: appointment.companyProfileImageUrl), placeholderImage: UIImage(named: "placeholderImage"))
        cell.descriptionLabel.text = "Randevu Saati : \(appointment.selectedTime)"
        cell.actionButton.addTarget(self, action: #selector(detailButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func detailButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toPastDetailSegue", sender: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}
