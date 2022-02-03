//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Eduardo Finotti on 09/01/22.
//

import SwiftUI

enum SignUpViewRouter {
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
}
