import Foundation
import FirebaseFirestore

class InstitutionalUserViewModel {
    var institutionalUsers: [InstitutionalUserModel] = [] {
        didSet {
            self.bindUsersToController()
        }
    }
    
    var bindUsersToController: (() -> ()) = {}
    
    func fetchCorporateData() {
        let db = Firestore.firestore()
        let corporateCollectionRef = db.collectionGroup("kurumsal")
        
        corporateCollectionRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                var fetchedUsers: [InstitutionalUserModel] = []
                
                for document in snapshot!.documents {
                    let data = document.data()
                    let documentID = document.reference.parent.parent?.documentID ?? "Unknown"
                    
                    let institutionalUser = InstitutionalUserModel(id: documentID, dictionary: data)
                    print("institutionalUser: \(institutionalUser)")
                    fetchedUsers.append(institutionalUser)
                }
                
                self.institutionalUsers = fetchedUsers
            }
        }
    }
}
