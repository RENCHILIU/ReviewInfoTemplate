//
//  File.swift
//  ReviewInfoTemplate
//
//  Created by Renchi Liu on 6/27/25.
//

import Foundation
import UIKit

class TestRootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let pushButton = UIButton(type: .system)
        pushButton.setTitle("Push Form Page", for: .normal)
        pushButton.titleLabel?.font = .systemFont(ofSize: 20)
        pushButton.addTarget(self, action: #selector(pushForm), for: .touchUpInside)
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        
        let presentButton = UIButton(type: .system)
        presentButton.setTitle("Present Form Page", for: .normal)
        presentButton.titleLabel?.font = .systemFont(ofSize: 20)
        presentButton.addTarget(self, action: #selector(presentForm), for: .touchUpInside)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [pushButton, presentButton])
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func pushForm() {
        let vc = makeDynamicFormVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func presentForm() {
        let vc = makeDynamicFormVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

    
    
    func makeDynamicFormVC(showClose: Bool = true) -> DynamicFormViewController {
        let manager = FormDataManager()
        manager.configure(with: [
            FormSection(
                type: .personal,
                fields: [.firstName, .lastName, .dob]
            ),
            FormSection(
                type: .contact,
                fields: [.homeAddress, .phoneNumber, .email]
            ),
            FormSection(
                type: .financial,
                fields: [.incomeAnnual, .incomeHousingCost, .incomeNonTaxable]
            ),
            FormSection(
                type: .security,
                fields: [.securityWordHint, .securityWord]
            )
        ])

        manager.configureCardInfo(
            cardName: "American Airlines AAdvantage®",
            userName: "Quinn",
            cardImage: UIImage(named: "card_placeholder")
        )
        
        // 创建并返回 VC
        return DynamicFormViewController(dataManager: manager, showCloseButton: showClose)

    }

}
