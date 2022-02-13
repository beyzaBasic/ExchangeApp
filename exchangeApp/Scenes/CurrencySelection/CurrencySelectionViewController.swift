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
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.tableFooterView = UIView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.allowsSelection = false
        table.tableFooterView = UIView()
        table.register(CurrencySelectionTableViewCell.self, forCellReuseIdentifier: CurrencySelectionTableViewCell.identifier)
        return table
    }()

    private lazy var lineView: UIView = { [unowned self] in
        let container = UIView()
        container.alpha = 0.3
        container.backgroundColor = .lightGray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var containerView: UIView = { [unowned self] in
        let container = UIView()
        container.layer.cornerRadius = 8
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Select Currency", comment: "")
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "closeIcon")
        imageView.layer.cornerRadius = 10
        imageView.tintColor = UIColor.Palette.blue
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(_:))))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.tableView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.lineView)
        self.containerView.addSubview(self.closeImageView)
        self.containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        self.containerView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        self.containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true

        self.tableView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.lineView.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10).isActive = true

        self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        self.closeImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20).isActive = true
        self.closeImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
        self.closeImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.closeImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.lineView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        self.lineView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        self.lineView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

    }
}
// MARK: - Actions
extension CurrencySelectionViewController {
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.viewModel.screenClosed()
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
        cell.delegate = self
        let condition = self.viewModel.selectedCondition(currency: currency)
        cell.configureCell(currency: currency, isSelected: condition)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: Currency Selection TableView Cell Delegate
extension CurrencySelectionViewController: CurrencySelectionTableViewCellDelegate {
    func currencySelected(currency: Currency) {
        self.viewModel.updateExchangeModelWithSelectedCurrency(currency: currency)
        self.tableView.reloadData()
    }
}
