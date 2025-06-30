import UIKit

class DynamicFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let dataManager: FormDataManager
    var showCloseButton: Bool
    private var editingSectionIndex: Int?
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    // 精简构造函数
    init(dataManager: FormDataManager, showCloseButton: Bool = true) {
        self.dataManager = dataManager
        self.showCloseButton = showCloseButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupHeaderAndFooter()
        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func closeTapped() {
        if let navigationController = navigationController, navigationController.viewControllers.first != self {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FormFieldCell.self, forCellReuseIdentifier: FormFieldCell.reuseIdentifier)
        tableView.register(FormSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: FormSectionHeaderView.reuseIdentifier)
        tableView.register(UpdateButtonCell.self, forCellReuseIdentifier: UpdateButtonCell.reuseIdentifier)
    }
    
    private func setupHeaderAndFooter() {
        let header = buildHeaderView()
        tableView.tableHeaderView = header
        tableView.tableFooterView = buildContinueButton()
    }
    
    private func buildHeaderView() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 240))
        let imageView = UIImageView(image: dataManager.cardImage)
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = dataManager.cardName
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome back, \(dataManager.userName)!"
        welcomeLabel.font = UIFont.systemFont(ofSize: 16)
        
        let indicatorLabel = UILabel()
        indicatorLabel.text = "Please confirm your details"
        indicatorLabel.font = UIFont.systemFont(ofSize: 14)
        indicatorLabel.textColor = .secondaryLabel
        
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, welcomeLabel, indicatorLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 160),
        ])
        
        // 仅在需要时加 close 按钮
        if showCloseButton {
            let closeButton = UIButton(type: .system)
            closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            closeButton.tintColor = .label
            closeButton.backgroundColor = .clear
            closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(closeButton)
            NSLayoutConstraint.activate([
                closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
                closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
                closeButton.widthAnchor.constraint(equalToConstant: 32),
                closeButton.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
        
        return container
    }

    
    private func buildContinueButton() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            button.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        return container
    }
    
    // MARK: - TableView 数据源与代理
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fieldCount = dataManager.fields(in: section).count
        if editingSectionIndex == section {
            return fieldCount + 1
        }
        return fieldCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = dataManager.section(at: section)
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FormSectionHeaderView.reuseIdentifier) as? FormSectionHeaderView else {
            return nil
        }
        header.configure(title: sectionModel.type.title) { [weak self] in
            guard let self = self else { return }
            let previousEditing = self.editingSectionIndex
            self.editingSectionIndex = (self.editingSectionIndex == section) ? nil : section
            var indexSet = IndexSet(integer: section)
            if let previous = previousEditing, previous != section {
                indexSet.insert(previous)
            }
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(indexSet, with: .none)
            }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fieldCount = dataManager.fields(in: indexPath.section).count
        if editingSectionIndex == indexPath.section && indexPath.row == fieldCount {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateButtonCell.reuseIdentifier, for: indexPath) as! UpdateButtonCell
            cell.onTap = { [weak self] in
                guard let self = self else { return }
                self.dataManager.updateSection(at: indexPath.section)
                self.editingSectionIndex = nil
                UIView.performWithoutAnimation {
                    self.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
                }
            }
            return cell
        }
        let field = dataManager.fields(in: indexPath.section)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormFieldCell.reuseIdentifier, for: indexPath) as! FormFieldCell
        let currentValue = dataManager.value(for: field)
        cell.configure(with: field, value: currentValue)
        cell.onValueChange = { [weak self] newValue in
            self?.dataManager.updateValue(for: field, value: newValue)
        }
        return cell
    }
}
