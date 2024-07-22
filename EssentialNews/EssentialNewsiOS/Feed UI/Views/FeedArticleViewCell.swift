//
//  FeedArticleViewCell.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/22/24.
//

import Foundation
import UIKit

public final class FeedArticleViewCell: UITableViewCell {
    
    var onRetry: (() -> Void)?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .white
        let configuration = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [descriptionLabel, publishedDateLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView(arrangedSubviews: [rightImageView, verticalStackView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 12
        horizontalStackView.alignment = .center
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(horizontalStackView)
        containerView.addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            rightImageView.widthAnchor.constraint(equalToConstant: 70),
            rightImageView.heightAnchor.constraint(equalToConstant: 70),
            retryButton.centerXAnchor.constraint(equalTo: rightImageView.centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: rightImageView.centerYAnchor),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}