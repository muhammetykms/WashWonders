import Foundation
import FirebaseFirestore
import FirebaseAuth

class InstitutionalAppointmentViewModel {
    var appointments: [InstitutionalAppointmentModel] = [] {
        didSet {
            print("Appointments set: \(appointments)")
            self.bindAppointmentsToController()
        }
    }
    
    var bindAppointmentsToController: (() -> ()) = {}
    
    func fetchAppointments() {
        print("Fetching appointments...")
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID not found")
            return
        }
        
        print("User ID: \(userID)")
        let appointmentsRef = db.collection("randevular").whereField("sellerId", isEqualTo: userID)
        print("appointmentsRef: \(appointmentsRef)")
        
        appointmentsRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                self.appointments = documents.compactMap { (document) -> InstitutionalAppointmentModel? in
                    let data = document.data()
                    print("Document data: \(data)")
                    return InstitutionalAppointmentModel(dictionary: data)
                }
                print("Fetched appointments: \(self.appointments)")
            }
        }
    }
    
    func fetchIndividualUserAppointments() {
        print("Fetching individual user appointments...")
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID not found")
            return
        }
        
        print("User ID: \(userID)")
        let appointmentsRef = db.collection("randevular").whereField("userId", isEqualTo: userID)
        print("appointmentsRef: \(appointmentsRef)")
        
        appointmentsRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                self.appointments = documents.compactMap { (document) -> InstitutionalAppointmentModel? in
                    var appointment = InstitutionalAppointmentModel(dictionary: document.data())
                    appointment.appointmentId = document.documentID
                    print("Document data: \(document.data())")
                    return appointment
                }
                print("Fetched individual user appointments: \(self.appointments)")
            }
        }
    }
    
    //Geçmiş randevuların veritabanından çekildiği kodlar
    func fetchPastAppointments() {
        print("Fetching past appointments...")
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID not found")
            return
        }
        
        print("User ID: \(userID)")
        let appointmentsRef = db.collection("gecmisRandevular").whereField("userId", isEqualTo: userID)
        print("appointmentsRef: \(appointmentsRef)")
        
        appointmentsRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                self.appointments = documents.compactMap { (document) -> InstitutionalAppointmentModel? in
                    var appointment = InstitutionalAppointmentModel(dictionary: document.data())
                    appointment.appointmentId = document.documentID
                    print("Document data: \(document.data())")
                    return appointment
                }
                print("Fetched past appointments: \(self.appointments)")
            }
        }
    }
}


