//
//  SignInViewRouter.swift
//  Habit
//
//  Created by Eduardo Finotti on 09/01/22.
//

import SwiftUI
import Combine

enum SigInViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel()
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
    
}
