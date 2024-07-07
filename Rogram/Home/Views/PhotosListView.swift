//
//  HomeListView.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import UIKit
import Combine

typealias PhotosSnapshot = NSDiffableDataSourceSnapshot<String, PhotoCellModel>

class PhotosListView: UIView {
            
    public var rowSelected: AnyPublisher<PhotoCellModel, Never> {
        rowSelectedSubject.eraseToAnyPublisher()
    }
    
    private let rowSelectedSubject = PassthroughSubject<PhotoCellModel, Never>()
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(PhotoCell.self, forCellReuseIdentifier: "photos")
        return tableview
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<String, PhotoCellModel> = {
        .init(tableView: tableview) { [weak self] tableview, indexPath, model -> UITableViewCell? in
            guard let self = self else {return nil}
            var model = model
            
            let cell = tableview.dequeueReusableCell(withIdentifier: "photos", for: indexPath) as? PhotoCell
            cell?.inject(model: model)
            
            return cell
        }
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
    }
    
    func addSubviews() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: topAnchor),
            tableview.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func apply(_ snapshot: PhotosSnapshot,
                      completion: (()-> Void)? = nil){
        dataSource.applySnapshotUsingReloadData(snapshot, completion: completion)
    }
}

extension PhotosListView: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = dataSource.itemIdentifier(for: indexPath) else { return }
        rowSelectedSubject.send(model)
    }
}
