//
//  HomeViewController.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

// MARK: - Class Bone
class HomeViewController: UIViewController {
    // MARK: Attributes
    private var viewModel: HomeViewModelProtocol

    // MARK: Properties
    private lazy var exchangeButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.backgroundColor = .clear
        button.backgroundColor = .yellow
        button.setTitle(NSLocalizedString("Exchange", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 26
        button.isEnabled = true
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.exchangeButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var denemeButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.backgroundColor = .clear
        button.backgroundColor = .yellow
        button.setTitle(NSLocalizedString("Currency", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 26
        button.isEnabled = true
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.denemeButtonTapped(_:)), for: .touchUpInside)
        return button
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
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - Set Up UI
extension HomeViewController {
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.exchangeButton)
        self.view.addSubview(self.denemeButton)

        self.navigationItem.title = NSLocalizedString("Exchange", comment: "")
        self.exchangeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.exchangeButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        self.exchangeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.exchangeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        self.denemeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.denemeButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        self.denemeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.denemeButton.topAnchor.constraint(equalTo: exchangeButton.bottomAnchor, constant: 80).isActive = true
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc private func exchangeButtonTapped(_ sender: UIButton) {
        self.viewModel.confirmationTriggered(self)
    }

    @objc private func denemeButtonTapped(_ sender: UIButton) {
        self.viewModel.selectCurrency(exchangeState: .fromCurrency, self)
    }
}
