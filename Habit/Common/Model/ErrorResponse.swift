//
//  ErrorResponse.swift
//  Habit
//
//  Created by Eduardo Finotti on 20/01/22.
//

import Foundation

struct ErrorResponse: Decodable {
    
    let detail: String

    enum CodingKeys: String, CodingKey {
        case detail
    }
}
