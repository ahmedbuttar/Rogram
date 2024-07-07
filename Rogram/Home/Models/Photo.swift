//
//  Photo.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation

typealias Photos = [Photo]

struct Photo: Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
