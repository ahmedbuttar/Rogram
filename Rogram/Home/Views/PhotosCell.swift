//
//  PhotosCell.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import UIKit
import SDWebImage

class PhotosCell: UITableViewCell {
    
    private var isLiked: Bool = false
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var likeView: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private lazy var photoInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 1.5
        stack.layer.borderColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.1).cgColor
        return stack
    }()
    
    private lazy var photoInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoView.sd_cancelCurrentImageLoad()
        photoView.image = nil
        isLiked = false
    }
    
    private func addSubviews(){
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        // Manually set constraints
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add title, spacer and a like button to horizontal stack view
        [titleView, UIView() ,likeView].forEach {
            photoInfoStackView.addArrangedSubview($0)
        }
        
        // Add titleStackView to photoInfoStackView
        photoInfoView.addSubview(photoInfoStackView)
        
        [photoView, photoInfoView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            photoInfoStackView.leadingAnchor.constraint(equalTo: photoInfoView.leadingAnchor, constant: 10),
            photoInfoStackView.trailingAnchor.constraint(equalTo: photoInfoView.trailingAnchor, constant: -10),
            photoInfoStackView.topAnchor.constraint(equalTo: photoInfoView.topAnchor),
            photoInfoStackView.bottomAnchor.constraint(equalTo: photoInfoView.bottomAnchor, constant: -10),
            photoView.heightAnchor.constraint(equalTo: stackView.widthAnchor),
            photoView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    
    public func inject(model: PhotosCellModel) {
        titleView.text = model.title
        photoView.sd_setImage(with: model.imageUrl)
    }
    
    @objc func likeAction() {
        isLiked.toggle()
        isLiked ? likeView.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal) :
        likeView.setImage(UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
    }
    
}
