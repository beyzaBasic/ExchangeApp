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
    private lazy var iconImageView: UIImageView = {  [unowned self] in
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greenIcon")
        // imageView.tintColor = UIColor(red: 38/255, green: 220/255, blue: 135/255, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Success", comment: "")
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("", comment: "")
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var backButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.backgroundColor = UIColor.Palette.blue
        button.setTitle(NSLocalizedString("Back To Exchange", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.feedResultData()
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
        self.view.backgroundColor = .white
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.iconImageView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.infoLabel)
        self.stackView.setCustomSpacing(20, after: self.iconImageView)
        self.view.addSubview(self.backButton)

        self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        self.backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.backButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
    }

    private func feedResultData() {
        if let exchangeModel = self.viewModel.exchangeModel, let value = exchangeModel.value, let result = exchangeModel.result {
            let fromCurrencyText = "\(round(10*value)/10) \(exchangeModel.fromCurrency.symbol)"
            let toCurrencyText = "\(exchangeModel.toCurrency.symbol) \(round(10*result)/10)"
            self.infoLabel.setAttributedText(texts:
                                                [TextAttributeModel(text: fromCurrencyText, attributes: nil),
                                                 TextAttributeModel(text: "  =  ", attributes: nil),
                                                 TextAttributeModel(text: toCurrencyText, attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold) ])])
        }
    }
}

// MARK: - Actions
extension SuccessViewController {
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.viewModel.backToHomeTapped()
    }
}
