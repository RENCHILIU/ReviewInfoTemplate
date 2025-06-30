import Foundation

class FormDataManager {
    private(set) var sections: [FormSectionType] = []
    
    /// 存储每个字段 key 对应的输入值
    private var values: [String: String] = [:]
    
    // 配置所有表单 section
    func configure(with sectionTypes: [FormSectionType]) {
        sections = sectionTypes
    }
    
    // section 相关
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func section(at index: Int) -> FormSectionType {
        return sections[index]
    }
    
    func fields(in section: Int) -> [FormFieldType] {
        return sections[section].fields
    }
    
    // 获取字段值
    func value(for field: FormFieldType) -> String? {
        return values[field.key]
    }
    
    // 更新字段值
    func updateValue(for field: FormFieldType, value: String) {
        values[field.key] = value
    }
    
    // 获取所有已填数据（可用于提交）
    func allValues() -> [String: String] {
        return values
    }
}
