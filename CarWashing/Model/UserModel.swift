import Foundation



struct UserModel {
    let email : String
    let name : String
    let password : String
    let profileImageUrl : String
    let surname : String
    let address : String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.surname = dictionary["surname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.address = dictionary["Address"] as? String ?? ""
    }
    
}
