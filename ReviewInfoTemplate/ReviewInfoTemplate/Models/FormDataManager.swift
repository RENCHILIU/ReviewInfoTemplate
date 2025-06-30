import Foundation
import UIKit

class FormDataManager {
    
    var cardName: String = ""
    var userName: String = ""
    var cardImage: UIImage? = nil
    
    private(set) var sections: [FormSection] = []
    private var values: [String: String] = [:]
    
    func configure(with sections: [FormSection]) {
        self.sections = sections
    }
    
    func numberOfSections() -> Int { sections.count }
    func section(at index: Int) -> FormSection { sections[index] }
    func fields(in section: Int) -> [FormFieldType] {
        return sections[section].fields.map { $0.fieldType }
    }
    func value(for field: FormFieldType) -> String? { values[field.key] }
    func updateValue(for field: FormFieldType, value: String) { values[field.key] = value }
    func allValues() -> [String: String] { values }
    
    func configureCardInfo(cardName: String, userName: String, cardImage: UIImage?) {
        self.cardName = cardName
        self.userName = userName
        self.cardImage = cardImage
    }
    
    // 重点：类型安全的 updateSection
    func updateSection(at sectionIndex: Int) {
        let section = sections[sectionIndex]
        switch section.type {
        case .personal:
            print("Update: Personal Info Section")
            // TODO: 业务逻辑
        case .contact:
            print("Update: Contact Info Section")
        case .financial:
            print("Update: Financial Info Section")
        case .security:
            print("Update: Security Section")
        case .authorizedUser:
            print("Update: Authorized User Section")
        }
    }
}
