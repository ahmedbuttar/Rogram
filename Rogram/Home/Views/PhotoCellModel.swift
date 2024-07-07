//
//  PhotoCellModel.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation

class PhotoCellModel: Hashable {
    
    let identifier: Int
    let title: String
    let imageUrl: URL
    
    init(identifier: Int,
         title: String,
         imageUrl: URL) {
        self.identifier = identifier
        self.title = title
        self.imageUrl = imageUrl
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: PhotoCellModel, rhs: PhotoCellModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
