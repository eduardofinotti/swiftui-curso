//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Eduardo Finotti on 07/01/22.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView() -> some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
}
