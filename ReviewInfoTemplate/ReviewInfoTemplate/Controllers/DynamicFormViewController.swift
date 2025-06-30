import UIKit

class DynamicFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let dataManager = FormDataManager()
    
    
    let userName = "Quinn"
    let cardName = "American Airlines AAdvantage®"
    let cardImage = UIImage(named: "card_placeholder") // 你可以放默认图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupHeaderAndFooter()
        dataManager.configure(with: [.personalInfo, .contactInfo, .financialInfo, .securityWord])
    }
    
    func setupTableView() {
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
    }
    
    func setupHeaderAndFooter() {
        let header = buildHeaderView()
        tableView.tableHeaderView = header
        tableView.tableFooterView = buildContinueButton()
    }
    
    func buildHeaderView() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 240))
        
        let imageView = UIImageView(image: cardImage)
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = cardName
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome back, \(userName)!"
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
        
        return container
    }
    
    func buildContinueButton() -> UIView {
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
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.fields(in: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataManager.section(at: section).title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
