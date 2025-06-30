//
//  UpdateButtonCell.swift
//  ReviewInfoTemplate
//
//  Created by Renchi Liu on 6/27/25.
//

import UIKit

class UpdateButtonCell: UITableViewCell {
    static let reuseIdentifier = "UpdateButtonCell"
    
    let button = UIButton(type: .system)
    
    var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    @objc func tap() {
        onTap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
