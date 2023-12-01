//
//  CountryTableViewCell.swift
//  Population
//
//  Created by Tekla on 12/1/23.
//

import UIKit

final class CountryTableViewCell: UITableViewCell {

    // MARK: - Private Properties
    private var countryLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
        
    // MARK: - init
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupSubviews()
            setupConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - PrepareForReuse
        override func prepareForReuse() {
            super.prepareForReuse()
            
            countryLabel.text = nil
        }

        // MARK: - Setup
        private func setupSubviews() {
            contentView.addSubview(countryLabel)
        }

        private func setupConstraints() {
            NSLayoutConstraint.activate([
                countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            ])
        }

        // MARK: - Configure
    func configure() {
        countryLabel.text = "Just configure for now, please."
        }
}
