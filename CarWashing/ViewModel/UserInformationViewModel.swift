import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserViewModel {
    var user: UserModel? {
        didSet {
            self.bindUserToController()
        }
    }
    
    var corporateUser: InstitutionalUserModel? {
        didSet {
            self.bindCorporateUserToController()
        }
    }
    
    var bindUserToController: (() -> ()) = {}
    var bindCorporateUserToController: (() -> ()) = {}
    
    func individualFetchUserDetails() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("users").document(userId).collection("bireysel").document("kullaniciBilgileri")
        
        userDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching individual user details: \(error)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Error: document does not exist")
                return
            }
            
            let data = document.data() ?? [:]
            let user = UserModel(dictionary: data)
            print("Fetched Individual User: \(user)")
            self.user = user
        }
    }
    
    //Yıkama Şirketlerinin Verilerin Çekilmesi
    func corporateFetchUserDetails() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userDocRef = db.collection("users").document(userId).collection("kurumsal").document("kullaniciBilgileri")
        
        userDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching corporate user details: \(error)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Error: document does not exist")
                return
            }
            
            let data = document.data() ?? [:]
            let user = InstitutionalUserModel(dictionary: data)
            print("Fetched Corporate User: \(user)")
            self.corporateUser = user
        }
    }
}
