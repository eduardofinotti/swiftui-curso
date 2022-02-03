//
//  SignUpView.swift
//  Habit
//
//  Created by Eduardo Finotti on 09/01/22.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false){
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        nameField
                        emailField
                        passwordField
                        documentField
                        phoneField
                        birthdayField
                        genderField
                        saveButton
                    }
                    Spacer()
                }.padding(.horizontal, 8)
                
            }.padding()
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Erro"), message: Text(value), dismissButton: .default(Text("Ok")){
                        })
                })
            }
        }
    }
}

extension SignUpView {
    var nameField: some View {
        EditTextView(text: $viewModel.name,
                     placeholder: "Nome completo",
                     keyboard: .alphabet,
                     error: "O nome deve ter 3 caracteres",
                     failure: viewModel.name.count < 3
        )
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress,
                     error: "Senha deve ser maior que 8",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "CPF",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: !viewModel.document.isCPF())
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Telefone",
                     keyboard: .numberPad,
                     error: "Entre com DDD + 9 digitos",
                     failure: viewModel.phone.count < 12)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Data de nascimento",
                     keyboard: .numbersAndPunctuation,
                     error: "Data deve ser dd/MM/yyyy",
                     failure: viewModel.birthday.count != 10)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) {value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

extension SignUpView {
        var saveButton: some View {
            LoadingButtomView(
                action: { viewModel.signUp() },
                text: "Cadastrar",
                showProgress: self.viewModel.uiState == SignUpUIState.loading,
                disabled: !viewModel.email.isEmail() || viewModel.password.count < 8 || !viewModel.document.isCPF())
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = SignUpViewModel()
            SignUpView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
