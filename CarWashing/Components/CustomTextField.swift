import UIKit

class CustomTextField: UITextField {


    init(placeholder: String? = nil, isSecureTextEntry: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        setupTextField()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        self.backgroundColor = .white
        self.textColor = .black
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1.1
        self.layer.borderColor = UIColor.white.cgColor
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.height))
        
        
    }
}
