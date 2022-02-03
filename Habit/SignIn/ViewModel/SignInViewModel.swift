//
//  SignInViewModel.swift
//  Habit
//
//  Created by Eduardo Finotti on 07/01/22.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    @Published var email = ""
    @Published var password = ""
    
    init(interactor: SignInInteractor){
        self.interactor = interactor
        
        cancellable = publisher.sink { value in
            print("usuario criado \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login() {
        
        // mudando o estado para loading, para o botao ccarregar...
        self.uiState = .loading
        
        // chama o interactor de login - o interactor que vai chamar o login de fato (no RemoteDataSource)
        // o cancellable é para cancelar caso aconteça algo no meio da operaçao (fechar o app, pr exemplo)
        cancellableRequest =  interactor.login(loginRequest: SignInRequest(email: email, password: password) )
            // estamos jogando isso pra thread principal
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // aqui acontece o error ou o finish
                switch(completion){
                case .failure(let appError):
                    self.uiState = SignInUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { success in
                // sucesso
                print(success)
                self.uiState = .goToHomeScreen
            }
    }
}

extension SignInViewModel {
    func homeView() -> some View {
        return SigInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SigInViewRouter.makeSignUpView(publisher: publisher)
    }
}
