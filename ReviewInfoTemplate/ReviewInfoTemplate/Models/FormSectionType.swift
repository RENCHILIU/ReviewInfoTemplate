import Foundation

enum FormSectionType {
    case personalInfo
    case contactInfo
    case financialInfo
    case securityWord
    
    var title: String {
        switch self {
        case .personalInfo: return "Personal Information"
        case .contactInfo: return "Contact Information"
        case .financialInfo: return "Financial Information"
        case .securityWord: return "Security Word"
        }
    }
    
    var fields: [FormFieldType] {
        switch self {
        case .personalInfo:
            return [.text(label: "Name", placeholder: "Enter name", key: "name"),
                    .text(label: "Country", placeholder: "Enter country", key: "country")]
        case .contactInfo:
            return [.text(label: "Address", placeholder: "Enter address", key: "address"),
                    .phone(label: "Mobile Phone", key: "phone"),
                    .email(label: "Email", key: "email")]
        case .financialInfo:
            return [.text(label: "Annual Income", placeholder: "$", key: "income"),
                    .text(label: "Housing Cost", placeholder: "$", key: "housing"),
                    .text(label: "Non-Taxable Income", placeholder: "$", key: "nontax")]
        case .securityWord:
            return [.text(label: "Hint", placeholder: "Favorite Pet", key: "hint"),
                    .secure(label: "Security Word", placeholder: "••••••", key: "word")]
        }
    }
}

enum FormFieldType: Equatable {
    case text(label: String, placeholder: String, key: String)
    case secure(label: String, placeholder: String, key: String)
    case phone(label: String, key: String)
    case email(label: String, key: String)
    
    var key: String {
        switch self {
        case .text(_, _, let key): return key
        case .secure(_, _, let key): return key
        case .phone(_, let key): return key
        case .email(_, let key): return key
        }
    }
    
    var label: String {
        switch self {
        case .text(let label, _, _): return label
        case .secure(let label, _, _): return label
        case .phone(let label, _): return label
        case .email(let label, _): return label
        }
    }
    
    // Optional: placeholder（用于通用渲染）
    var placeholder: String {
        switch self {
        case .text(_, let placeholder, _): return placeholder
        case .secure(_, let placeholder, _): return placeholder
        case .phone: return "Enter phone number"
        case .email: return "example@email.com"
        }
    }
    
    // Optional: 用于调试打印
    var debugDescription: String {
        return "[\(label): \(key)]"
    }
}
