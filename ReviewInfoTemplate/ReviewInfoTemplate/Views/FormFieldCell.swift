// FormFieldCell.swift

import UIKit

final class FormFieldCell: UITableViewCell {
    
    static let reuseIdentifier = "FormFieldCell"
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    private var fieldType: FormFieldType?
    
    var onValueChange: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with field: FormFieldType, value: String?) {
        self.fieldType = field
        
        switch field {
        case .text(let label, let placeholder, _):
            titleLabel.text = label
            textField.placeholder = placeholder
            textField.isSecureTextEntry = false
            textField.keyboardType = .default
            
        case .secure(let label, let placeholder, _):
            titleLabel.text = label
            textField.placeholder = placeholder
            textField.isSecureTextEntry = true
            textField.keyboardType = .default
            
        case .email(let label, let key):
            titleLabel.text = label
            textField.placeholder = "example@email.com"
            textField.isSecureTextEntry = false
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            
        case .phone(let label, let key):
            titleLabel.text = label
            textField.placeholder = "Enter phone number"
            textField.isSecureTextEntry = false
            textField.keyboardType = .phonePad
        }
        
        textField.text = value
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        onValueChange?(sender.text ?? "")
    }
}

