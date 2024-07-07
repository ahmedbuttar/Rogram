//
//  Response.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation

struct Response {
    var data: Data
    
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    func jsonResponse<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
