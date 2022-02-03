//
//  SignInView.swift
//  Habit
//
//  Created by Eduardo Finotti on 07/01/22.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var  action: Int? = 0
    @State var  navigationHidden = true
    
    var body: some View {
        
        ZStack {
//            switch viewModel.uiState {
//                case .goToHomeScreen:
//                    Text("Tela principal")
//                default:
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
//              Text("Tela principal") // montando tela atual (login) com texto somente
                viewModel.homeView()
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer(minLength: 100)
                            
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                    .padding(.vertical, 30)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                Text("Copyright @YYY")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 16).bold())
                                    .padding(50)
                            }
                        }
                        
                        if case SignInUIState.error(let value) = viewModel.uiState{
                            Text("")
                                .alert(isPresented: .constant(true), content: {
                                    Alert(title: Text(value), message: Text(value), dismissButton: .default(Text("Ok")){
                                    })
                                })
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    .padding(.horizontal, 32)
//                    .background(Color.white)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
                .onAppear{
                    self.navigationHidden = true
                }
                .onDisappear(){
                    self.navigationHidden = false
                }
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress,
                     error: "Senha deve ser maior que 8",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtomView(
            action: { viewModel.login() },
            text: "Entrar",
            showProgress: self.viewModel.uiState == SignInUIState.loading,
            disabled: !viewModel.email.isEmail() || viewModel.password.count < 8)
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda nao possui login?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: 1,
                    selection: $action,
                    label: {
                        EmptyView()
                    })
                
                Button("Realize seu cadastro"){
                    self.action = 1
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = SignInViewModel(interactor: SignInInteractor())
            SignInView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
