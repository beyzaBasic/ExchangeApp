//
//  CurrencySelectionViewController.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

// MARK: - Class Bone
class CurrencySelectionViewController: UIViewController {
    // MARK: Attributes
    private var viewModel: CurrencySelectionViewModelProtocol

    // MARK: Properties
    private lazy var tableView: UITableView = { [unowned self] in
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.showsVerticalScrollIndicator = false
        table.tableFooterView = UIView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = true
        table.register(CurrencySelectionTableViewCell.self, forCellReuseIdentifier: CurrencySelectionTableViewCell.identifier)
        return table
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: Cons & Decons
    init(viewModel: CurrencySelectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Set Up UI
extension CurrencySelectionViewController {
    private func setUpUI() {
        self.view.backgroundColor = .clear
        self.view.addSubview(self.tableView)
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true

    }
}

// MARK: - UITableView Delegate DataSource
extension CurrencySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.currencyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectionTableViewCell.identifier, for: indexPath) as! CurrencySelectionTableViewCell
        let currency = self.viewModel.currencyList[indexPath.row]
        cell.configureCell(currency: currency)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.screenClosed(index: indexPath.row)

    }

}

