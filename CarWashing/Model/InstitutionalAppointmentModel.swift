import Foundation

struct InstitutionalAppointmentModel {
    var appointmentId: String?
    let companyName: String
    let companyProfileImageUrl: String
    let selectedService: String
    let date: String
    let name: String
    let selectedTime: String
    let sellerId: String
    let timestamp: Double
    let surname: String
    let userProfileImageUrl: String
    let userId: String
    let valeService: Any
    
    init(dictionary: [String: Any]) {
        self.companyName = dictionary["companyName"] as? String ?? ""
        self.companyProfileImageUrl = dictionary["companyProfileImageUrl"] as? String ?? ""
        self.selectedService = dictionary["selectedService"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.selectedTime = dictionary["selectedTime"] as? String ?? ""
        self.sellerId = dictionary["sellerId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Double ?? 0
        self.surname = dictionary["surname"] as? String ?? ""
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
        self.valeService = dictionary["valeService"] ?? false
    }
}
