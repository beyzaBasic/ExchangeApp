//
//  CurrencySelectionTableViewCell.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 12.02.2022.
//

import UIKit

// MARK: - Class Bone
class CurrencySelectionTableViewCell: UITableViewCell {
    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Title", comment: "")
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Attributes
    static let identifier = "CurrencySelectionTableViewCell"

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
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
}

// MARK: - Public
extension CurrencySelectionTableViewCell {
    func configureCell(currency: Currency) {
        titleLabel.text = currency.title
    }
}

