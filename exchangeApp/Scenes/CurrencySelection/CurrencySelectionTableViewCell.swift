//
//  CurrencySelectionTableViewCell.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 12.02.2022.
//

import UIKit

protocol CurrencySelectionTableViewCellDelegate: AnyObject {
    func currencySelected(currency: Currency)
}
// MARK: - Class Bone
class CurrencySelectionTableViewCell: UITableViewCell {
    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Title", comment: "")
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .lightGray
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectButtonTapped(_:))))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Attributes
    static let identifier = "CurrencySelectionTableViewCell"
    weak var delegate: CurrencySelectionTableViewCellDelegate?
    private(set) var currency: Currency?

    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        self.setUpUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - UI
extension CurrencySelectionTableViewCell {
    private func setUpUI() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.iconImageView)

        self.iconImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true

        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
}

// MARK: - Actions
extension CurrencySelectionTableViewCell {
    @objc func selectButtonTapped(_ : UIButton) {
        guard let currency = self.currency else { return}
        self.iconImageView.image = UIImage(named: "selectIcon")
        self.iconImageView.backgroundColor = .white
        self.delegate?.currencySelected(currency: currency)
    }
}
// MARK: - Public
extension CurrencySelectionTableViewCell {
    func configureCell(currency: Currency, isSelected: Bool) {
        titleLabel.text = currency.title
        self.currency = currency
        if isSelected {
            self.iconImageView.image = UIImage(named: "selectIcon")
            self.iconImageView.backgroundColor = .white
            self.iconImageView.alpha = 1
            self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        } else {
            self.iconImageView.image = nil
            self.iconImageView.backgroundColor = .lightGray
            self.iconImageView.alpha = 0.3
            self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
    }
}

