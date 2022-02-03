//
//  SignInUIState.swift
//  Habit
//
//  Created by Eduardo Finotti on 09/01/22.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}

