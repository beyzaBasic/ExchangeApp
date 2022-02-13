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
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var lineView: UIView = { [unowned self] in
        let container = UIView()
        container.layer.cornerRadius = 0.5
        container.alpha = 0.8
        container.backgroundColor = .lightGray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("", comment: "")
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var rateLabel: InsetLabel = { [unowned self] in
        let label = InsetLabel()
        label.text = NSLocalizedString("", comment: "")
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
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
        self.updateAmountUI(textField: self.currencyTextField)
        self.updateExchangeButtonUI(textField: self.currencyTextField)

        self.viewModel.getRatesFromCloudIfNeeded { rateModel in
            self.updateRateUI()
        } onFailure: { networkError in
            
        }

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
        self.verticalStackView.addArrangedSubview(self.topStackView)
        self.verticalStackView.addArrangedSubview(self.currencyTextField)
        self.verticalStackView.addArrangedSubview(self.amountLabel)
        self.verticalStackView.addSubview(self.lineView)
        self.verticalStackView.addArrangedSubview(self.rateLabel)
        self.verticalStackView.addArrangedSubview(self.exchangeButton)
        self.navigationItem.title = NSLocalizedString("Exchange", comment: "")

        self.verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true

        self.verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.verticalStackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        self.verticalStackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true

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
        self.rightButtonView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.leftButtonView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.currencyTextField.heightAnchor.constraint(equalTo: self.topStackView.heightAnchor, multiplier: 2).isActive = true
        self.lineView.topAnchor.constraint(equalTo: self.currencyTextField.bottomAnchor, constant: 5).isActive = true
        self.lineView.centerXAnchor.constraint(equalTo: self.currencyTextField.centerXAnchor).isActive = true
        self.lineView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    private func updateAmountUI(textField: UITextField) {

        if let text = textField.text, !text.isEmpty, let doubleValue = Double(text) {
            self.viewModel.updateExchangeValue(value: doubleValue)
        } else {
            self.viewModel.updateExchangeValue(value: 0)
        }

        self.viewModel.setExchangeModelResultWithRateCalculation()
        let amountText = NSLocalizedString("Final Amount: ", comment: "")
        let amountSymbol = self.viewModel.exchangeModel.toCurrency.symbol
        let amountInfo: Double = self.viewModel.exchangeModel.result != nil ? round(10 * self.viewModel.exchangeModel.result!) / 10 : 0

        self.amountLabel.setAttributedText(texts:
                                            [TextAttributeModel(text: amountText, attributes: nil),
                                             TextAttributeModel(text: amountSymbol, attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold)]),
                                             TextAttributeModel(text: amountInfo.description, attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold)])])
    }

    private func updateRateUI() {
        self.rateLabel.text = "1 \(self.viewModel.exchangeModel.fromCurrency.title) = \(round (100 * (self.viewModel.exchangeModel.toCurrency.rate / self.viewModel.exchangeModel.fromCurrency.rate)) / 100) \(self.viewModel.exchangeModel.toCurrency.title)"
    }

    private func toggleCurrencyButtonUI() {
        self.viewModel.toggleFromToCurrencies()
        self.updateCurrencyButtonUI()
    }

    private func updateCurrencyButtonUI() {
        if let leftLabel = self.view.viewWithTag(44) as? UILabel {
            leftLabel.text = self.viewModel.exchangeModel.fromCurrency.title
        }
        if let rightLabel = self.view.viewWithTag(45) as? UILabel {
            rightLabel.text = self.viewModel.exchangeModel.toCurrency.title
        }
    }

    private func updateExchangeButtonUI(textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            self.exchangeButton.isEnabled = true
            self.exchangeButton.alpha = 1
        } else {
            self.exchangeButton.isEnabled = false
            self.exchangeButton.alpha = 0.5
        }
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc private func exchangeButtonTapped(_ sender: UIButton) {
        self.viewModel.confirmationTriggered(exchangeModel: self.viewModel.exchangeModel, self)
    }

    @objc private func toggleButtonTapped(_ sender: UIButton) {
        self.toggleCurrencyButtonUI()
        self.updateRateUI()
        self.updateAmountUI(textField: self.currencyTextField)
    }

    @objc private func leftButtonTapped(_ sender: UIButton) {
        self.viewModel.updateSelectionState(selectionState: .fromCurrency, self)
    }

    @objc private func rightButtonTapped(_ sender: UIButton) {
        self.viewModel.updateSelectionState(selectionState: .toCurrency, self)
    }

    @objc func textChanged(_ sender: UITextField) {
        self.updateExchangeButtonUI(textField: self.currencyTextField)
        self.updateAmountUI(textField: self.currencyTextField)
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

extension HomeViewController: CurrencySelectionViewModelViewDelegate {
    func updateUI() {
        self.viewModel.updateFromToCurrenciesWithRateData()
        self.updateCurrencyButtonUI()
        self.updateRateUI()
        self.updateAmountUI(textField: self.currencyTextField)
    }
}

extension HomeViewController: SuccessViewModelViewDelegate {
    func resetUI() {
        self.viewModel.resetFromToCurrenciesWithRateData()
        self.updateCurrencyButtonUI()
        self.updateRateUI()
        self.currencyTextField.text = ""
        self.updateAmountUI(textField: self.currencyTextField)
    }
}
