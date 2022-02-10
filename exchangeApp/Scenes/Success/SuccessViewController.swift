//
//  SuccessViewController.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

// MARK: - Class Bone
class SuccessViewController: UIViewController {
    // MARK: Attributes
    private var viewModel: SuccessViewModelProtocol

    // MARK: Properties
    private lazy var backButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.backgroundColor = .clear
        button.backgroundColor = .yellow
        button.setTitle(NSLocalizedString("Back To Home", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 26
        button.isEnabled = true
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
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
    init(viewModel: SuccessViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - Set Up UI
extension SuccessViewController {
    private func setUpUI() {
        self.view.backgroundColor = .red
        self.view.addSubview(self.backButton)
        self.backButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        self.backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.backButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

// MARK: - Actions
extension SuccessViewController {
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.viewModel.backToHomeTapped()
    }
}
