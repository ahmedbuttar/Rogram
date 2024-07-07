//
//  HomeViewController.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import Combine
import UIKit

class HomeViewController: UIViewController {
    
    private let listView = PhotosListView()
    private let viewModel: HomeViewModelProtocol = HomeViewModel(getPhotosUseCase: GetPhotosUseCase(networkService: NetworkService()))

    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setBindings()
        
        title = "Ro"
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

private extension HomeViewController {
    func setBindings() {
        viewModel.refreshData()
            .sink{ [weak self] snapshot in
                guard let self = self else { return }
                self.listView.apply(snapshot)
            }
            .store(in: &cancellables)
        
        listView.rowSelected
            .sink { [weak self] model in
                guard let photo = self?.viewModel.getPhoto(with: model.identifier) else { return }
                let photosDetailViewController = PhotosDetailViewController(photoDetail: .init(id: photo.id, 
                                                                                               title: photo.title,
                                                                                               url: photo.url))
                photosDetailViewController.modalPresentationStyle = .fullScreen
                self?.present(photosDetailViewController, animated: true, completion: nil)
            }
            .store(in: &cancellables)
    }
}
