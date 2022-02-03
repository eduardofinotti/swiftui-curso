//
//  SignUpUIState.swift
//  Habit
//
//  Created by Eduardo Finotti on 09/01/22.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
