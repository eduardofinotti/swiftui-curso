//
//  SplashViewModel.swift
//  Habit
//
//  Created by Eduardo Finotti on 07/01/22.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    func onAppear() {
        // faz algo asyncrono e muda o estado da uiState
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // chamado depois de 2 segundos
            self.uiState = .goToSignInScreen
        }
    }
}
    
extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
