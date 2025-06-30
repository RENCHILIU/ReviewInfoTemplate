import Foundation

// MARK: - 枚举化所有支持的表单字段类型
enum FormFieldKind {
    // MARK: - Applicant Info
    case fullName
    case firstName
    case lastName
    case middleName
    case suffixTitle
    case homeAddress
    case ssn
    case dob
    case citizenship
    case phoneNumber
    case phoneNumberType
    case email
    case securityWord
    case securityWordHint
    
    // MARK: - Income Info
    case incomeAnnual
    case incomeHousingCost
    case incomeNonTaxable
    
    // MARK: - Authorized User
    case addAuthorizedUser
    case authorizedUserName
    case authorizedUserSSN
    case authorizedUserDob
    case authorizedUserEmail
    case authorizedUserAddress
    case authorizedUserSameAddress
    
    // MARK: - Membership Info
    case aaMembershipNumber
    case costcoMembershipNumber
    case authUserCostcoMembershipNumber
    case haveAAMembership
    case knowAAMembership
}

// MARK: - 字段元数据及UI适配
extension FormFieldKind {
    var label: String {
        switch self {
        case .fullName: return "Full Name"
        case .firstName: return "First Name"
        case .lastName: return "Last Name"
        case .middleName: return "Middle Name"
        case .suffixTitle: return "Suffix"
        case .homeAddress: return "Home Address"
        case .ssn: return "SSN"
        case .dob: return "Date of Birth"
        case .citizenship: return "Country of Citizenship"
        case .phoneNumber: return "Mobile Phone"
        case .phoneNumberType: return "Phone Number Type"
        case .email: return "Email"
        case .securityWord: return "Security Word"
        case .securityWordHint: return "Security Word Hint"
        case .incomeAnnual: return "Annual Income"
        case .incomeHousingCost: return "Housing Cost"
        case .incomeNonTaxable: return "Non-Taxable Income"
        case .addAuthorizedUser: return "Add Authorized User"
        case .authorizedUserName: return "Authorized User Name"
        case .authorizedUserSSN: return "Authorized User SSN"
        case .authorizedUserDob: return "Authorized User Date of Birth"
        case .authorizedUserEmail: return "Authorized User Email"
        case .authorizedUserAddress: return "Authorized User Address"
        case .authorizedUserSameAddress: return "Authorized User Same Address"
        case .aaMembershipNumber: return "AA Membership Number"
        case .costcoMembershipNumber: return "Costco Membership Number"
        case .authUserCostcoMembershipNumber: return "Authorized User Costco Membership Number"
        case .haveAAMembership: return "Have AA Membership"
        case .knowAAMembership: return "Know AA Membership"
        }
    }
    
    var placeholder: String {
        switch self {
        case .fullName: return "Enter full name"
        case .firstName: return "Enter first name"
        case .lastName: return "Enter last name"
        case .middleName: return "Enter middle name"
        case .suffixTitle: return "Enter suffix"
        case .homeAddress: return "Enter address"
        case .ssn: return "Enter SSN"
        case .dob: return "MM/DD/YYYY"
        case .citizenship: return "Enter country"
        case .phoneNumber: return "Enter phone number"
        case .phoneNumberType: return "Mobile/Home/Work"
        case .email: return "example@email.com"
        case .securityWord: return "••••••"
        case .securityWordHint: return "Favorite Pet"
        case .incomeAnnual: return "$"
        case .incomeHousingCost: return "$"
        case .incomeNonTaxable: return "$"
        case .addAuthorizedUser: return ""
        case .authorizedUserName: return "Enter name"
        case .authorizedUserSSN: return "Enter SSN"
        case .authorizedUserDob: return "MM/DD/YYYY"
        case .authorizedUserEmail: return "example@email.com"
        case .authorizedUserAddress: return "Enter address"
        case .authorizedUserSameAddress: return ""
        case .aaMembershipNumber: return "Enter AA membership number"
        case .costcoMembershipNumber: return "Enter Costco membership number"
        case .authUserCostcoMembershipNumber: return "Enter membership number"
        case .haveAAMembership: return ""
        case .knowAAMembership: return ""
        }
    }
    
    var key: String {
        switch self {
        case .fullName: return "fullName"
        case .firstName: return "firstName"
        case .lastName: return "lastName"
        case .middleName: return "middleName"
        case .suffixTitle: return "suffixTitle"
        case .homeAddress: return "homeAddress"
        case .ssn: return "ssn"
        case .dob: return "dob"
        case .citizenship: return "citizenship"
        case .phoneNumber: return "phoneNumber"
        case .phoneNumberType: return "phoneNumberType"
        case .email: return "email"
        case .securityWord: return "securityWord"
        case .securityWordHint: return "securityWordHint"
        case .incomeAnnual: return "incomeAnnual"
        case .incomeHousingCost: return "incomeHousingCost"
        case .incomeNonTaxable: return "incomeNonTaxable"
        case .addAuthorizedUser: return "addAuthorizedUser"
        case .authorizedUserName: return "authorizedUserName"
        case .authorizedUserSSN: return "authorizedUserSSN"
        case .authorizedUserDob: return "authorizedUserDob"
        case .authorizedUserEmail: return "authorizedUserEmail"
        case .authorizedUserAddress: return "authorizedUserAddress"
        case .authorizedUserSameAddress: return "authorizedUserSameAddress"
        case .aaMembershipNumber: return "aaMembershipNumber"
        case .costcoMembershipNumber: return "costcoMembershipNumber"
        case .authUserCostcoMembershipNumber: return "authUserCostcoMembershipNumber"
        case .haveAAMembership: return "haveAAMembership"
        case .knowAAMembership: return "knowAAMembership"
        }
    }
    
    // 自动推导对应的 FormFieldType
    var fieldType: FormFieldType {
        switch self {
        case .ssn, .securityWord, .authorizedUserSSN:
            return .secure(label: label, placeholder: placeholder, key: key)
        case .email, .authorizedUserEmail:
            return .email(label: label, key: key)
        case .phoneNumber:
            return .phone(label: label, key: key)
            // 布尔、选项型等可以后续扩展自定义
        default:
            return .text(label: label, placeholder: placeholder, key: key)
        }
    }
}

enum SectionType: String, CaseIterable {
    case personal
    case contact
    case financial
    case security
    case authorizedUser
    
    var title: String {
        switch self {
        case .personal: return "Personal Information"
        case .contact: return "Contact Information"
        case .financial: return "Financial Information"
        case .security: return "Security Word"
        case .authorizedUser: return "Authorized User"
        }
    }
}

struct FormSection {
    let type: SectionType
    let fields: [FormFieldKind]
}


// MARK: - 字段控件类型，适配 Cell
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
    var placeholder: String {
        switch self {
        case .text(_, let placeholder, _): return placeholder
        case .secure(_, let placeholder, _): return placeholder
        case .phone: return "Enter phone number"
        case .email: return "example@email.com"
        }
    }
    var debugDescription: String {
        return "[\(label): \(key)]"
    }
}
