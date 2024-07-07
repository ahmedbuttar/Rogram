//
//  PhotosDetailViewController.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import UIKit
import SDWebImage

class PhotosDetailViewController: UIViewController {
    
    private let photoDetail: PhotoDetail
    
    init(photoDetail: PhotoDetail) {
        self.photoDetail = photoDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var close: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_setImage(with: photoDetail.url)
        return imageView
    }()
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = photoDetail.title
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        [close, photoView, titleView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            close.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            close.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor),
            photoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func dismissAction() {
        dismiss(animated: true)
    }
    
}
