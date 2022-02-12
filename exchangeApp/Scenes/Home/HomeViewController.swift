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
        button.backgroundColor = UIColor.Palette.blue
        button.setTitle(NSLocalizedString("Exchange", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 8
        button.isEnabled = true
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.exchangeButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var leftButtonView: UIView = { [unowned self] in
        let container = UIView()
        container.layer.cornerRadius = 18
        container.backgroundColor = .lightGray
        container.alpha = 0.1
        container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (leftButtonTapped(_:))))
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var rightButtonView: UIView = { [unowned self] in
        let container = UIView()
        container.layer.cornerRadius = 18
        container.backgroundColor = .lightGray
        container.alpha = 0.1
        container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (rightButtonTapped(_:))))
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var toggleButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setImage(UIImage(named: "exchange"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.tintColor = UIColor.Palette.blue
        button.isEnabled = true
        button.alpha = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.toggleButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private func createArrowView() -> UIView {
        let view = CustomArrow(frame: .zero)
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func createCuncurrencyLabel() -> UILabel {
        let label = UILabel()
        label.text = NSLocalizedString("USD", comment: "")
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.alpha = 0.8
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = UIColor.Palette.blue
        textField.font = UIFont.systemFont(ofSize: 50, weight: .medium)
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.backgroundColor = .red
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("", comment: "")
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("", comment: "")
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setRateData()
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


        self.view.addSubview(self.verticalStackView)
        self.view.addSubview(self.exchangeButton)
        self.verticalStackView.addArrangedSubview(self.topStackView)
        self.verticalStackView.addArrangedSubview(self.currencyTextField)
        self.verticalStackView.addArrangedSubview(self.amountLabel)
        self.verticalStackView.addArrangedSubview(self.rateLabel)
        self.navigationItem.title = NSLocalizedString("Exchange", comment: "")

        self.verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true

        self.verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.verticalStackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        self.verticalStackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3).isActive = true

        self.exchangeButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.exchangeButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        self.topStackView.addArrangedSubview(self.leftButtonView)
        self.topStackView.addArrangedSubview(self.toggleButton)
        self.topStackView.addArrangedSubview(self.rightButtonView)

        let leftArrow = self.createArrowView()
        let leftCurrencyLabel = self.createCuncurrencyLabel()
        leftCurrencyLabel.tag = 44
        leftCurrencyLabel.text = self.viewModel.exchangeModel.fromCurrency.title
        let rightArrow = self.createArrowView()
        let rightCurrencyLabel = self.createCuncurrencyLabel()
        rightCurrencyLabel.text = self.viewModel.exchangeModel.toCurrency.title
        rightCurrencyLabel.tag = 45

        self.topStackView.addSubview(leftArrow)
        self.topStackView.addSubview(leftCurrencyLabel)
        self.topStackView.addSubview(rightArrow)
        self.topStackView.addSubview(rightCurrencyLabel)

        self.topStackView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.topStackView.widthAnchor.constraint(equalTo: self.exchangeButton.widthAnchor, multiplier: 0.8).isActive = true

        rightArrow.trailingAnchor.constraint(equalTo: self.rightButtonView.trailingAnchor, constant: -10).isActive = true
        rightArrow.heightAnchor.constraint(equalToConstant: 7).isActive = true
        rightArrow.widthAnchor.constraint(equalToConstant: 11).isActive = true
        rightArrow.centerYAnchor.constraint(equalTo: self.leftButtonView.centerYAnchor).isActive = true
        leftArrow.trailingAnchor.constraint(equalTo: self.leftButtonView.trailingAnchor, constant: -10).isActive = true
        leftArrow.heightAnchor.constraint(equalToConstant: 7).isActive = true
        leftArrow.widthAnchor.constraint(equalToConstant: 11).isActive = true
        leftArrow.centerYAnchor.constraint(equalTo: self.leftButtonView.centerYAnchor).isActive = true
        rightCurrencyLabel.centerYAnchor.constraint(equalTo: self.rightButtonView.centerYAnchor).isActive = true
        rightCurrencyLabel.leadingAnchor.constraint(equalTo: self.rightButtonView.leadingAnchor, constant: 15).isActive = true
        leftCurrencyLabel.centerYAnchor.constraint(equalTo: self.leftButtonView.centerYAnchor).isActive = true
        leftCurrencyLabel.leadingAnchor.constraint(equalTo: self.leftButtonView.leadingAnchor, constant: 15).isActive = true

        self.toggleButton.widthAnchor.constraint(equalTo: self.toggleButton.heightAnchor).isActive = true
        self.exchangeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        self.exchangeButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.rightButtonView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.leftButtonView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.currencyTextField.heightAnchor.constraint(equalTo: self.topStackView.heightAnchor, multiplier: 2).isActive = true
    }

    private func setAmountData() {
        let amountText = "Final Amount: "
        let amountInfo = self.viewModel.exchangeModel.toCurrency.symbol + ((self.viewModel.exchangeModel.value ?? 0)/2).description
        self.amountLabel.text = NSLocalizedString(amountText, comment: "") + " " + amountInfo
    }

    private func setRateData() {
        self.rateLabel.text = " 1 \(self.viewModel.exchangeModel.fromCurrency.title) = 0.5 \(self.viewModel.exchangeModel.toCurrency.title)"
    }

}

// MARK: - Actions
extension HomeViewController {
    @objc private func exchangeButtonTapped(_ sender: UIButton) {
        self.viewModel.confirmationTriggered(self)
    }

    @objc private func toggleButtonTapped(_ sender: UIButton) {
        let  tempFromVal = self.viewModel.exchangeModel.fromCurrency
        self.viewModel.exchangeModel.fromCurrency = self.viewModel.exchangeModel.toCurrency
        self.viewModel.exchangeModel.toCurrency = tempFromVal

        if let leftLabel = self.view.viewWithTag(44) as? UILabel {
            leftLabel.text = self.viewModel.exchangeModel.fromCurrency.title
        }
        if let rightLabel = self.view.viewWithTag(45) as? UILabel {
            rightLabel.text = self.viewModel.exchangeModel.toCurrency.title
        }

        self.setRateData()

    }

    @objc private func leftButtonTapped(_ sender: UIButton) {
        self.viewModel.selectCurrency(exchangeModel: self.viewModel.exchangeModel,  self)
    }

    @objc private func rightButtonTapped(_ sender: UIButton) {
        self.viewModel.selectCurrency(exchangeModel: self.viewModel.exchangeModel, self)
    }

    @objc func textChanged(_ sender: UITextField) {
        if let text = currencyTextField.text, !text.isEmpty, let doubleValue = Double(text) {
            self.viewModel.exchangeModel.value = doubleValue
            self.setAmountData()
        }
    }
}

// MARK: - UITextField Delegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            textField.resignFirstResponder()
            return true}
        return false
    }
}
