import Foundation

struct InstitutionalUserModel {
    var id: String?
    let companyName: String
    let address: String
    let email: String
    let password: String
    let profileImage: String
    let capacityCount: Int
    
    init(id: String? = nil,dictionary: [String: Any]) {
        self.id = id
        self.companyName = dictionary["CompanyName"] as? String ?? ""
        self.address = dictionary["Address"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
        self.capacityCount = dictionary["CapacityCount"] as? Int ?? 1
    }
}
