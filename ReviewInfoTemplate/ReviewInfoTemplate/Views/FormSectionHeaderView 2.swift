import UIKit

class FormSectionHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "FormSectionHeaderView"

    let titleLabel = UILabel()
    let editButton = UIButton(type: .system)

    var onEditTapped: (() -> Void)?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        editButton.setTitle("Edit", for: .normal)
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, editButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    @objc private func editTapped() {
        onEditTapped?()
    }

    func configure(title: String, onEdit: @escaping () -> Void) {
        titleLabel.text = title
        onEditTapped = onEdit
    }
}