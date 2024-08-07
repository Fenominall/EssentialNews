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
        view.backgroundColor = .systemBackground
        return view
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    public lazy var publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    public lazy var articlesImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    public lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .label
        let configuration = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [descriptionLabel, publishedDateLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView(arrangedSubviews: [articlesImageContainer, verticalStackView])
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
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(containerView)
        containerView.addSubview(horizontalStackView)
        containerView.addSubview(retryButton)
        articlesImageContainer.addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            articlesImageContainer.widthAnchor.constraint(equalToConstant: 100),
            articlesImageContainer.heightAnchor.constraint(equalToConstant: 100),
            articleImageView.widthAnchor.constraint(equalToConstant: 100),
            articleImageView.heightAnchor.constraint(equalToConstant: 100),
            articleImageView.centerXAnchor.constraint(equalTo: articlesImageContainer.centerXAnchor),
            articleImageView.centerYAnchor.constraint(equalTo: articlesImageContainer.centerYAnchor),
            
            retryButton.centerXAnchor.constraint(equalTo: articleImageView.centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: articleImageView.centerYAnchor),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
