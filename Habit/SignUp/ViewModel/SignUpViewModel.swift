//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Eduardo Finotti on 09/01/22.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUIState = .none
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    
    func signUp() {
        self.uiState = .loading
        
        // DATA
        // pegar a string -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        // Validar data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday =  formatter.string(from: dateFormatted)
        
        WebService.postUser(request: SignUpRequest(fullName: name, email: email, password: password, document: document, phone: phone, birthday: birthday, gender: gender.index)) {
            (successResponse, errorResponse) in
            
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            
            if let success = successResponse {
                
//                WebService.login(request: SignInRequest(email: self.email, password: self.password) ) {
//                    (successResponse, errorResponse) in
//                    
//                     if let errorSignIn = errorResponse {
//                        DispatchQueue.main.async {
//                            self.uiState = .error(errorSignIn.detail.message)
//                        }
//                    }
//                    
//                    if let successSignIn = successResponse {
//                        DispatchQueue.main.async {
//                            print(successSignIn)
//                            self.publisher.send(success)
//                            self.uiState = .success
//                        }
//                    }
//                }
                
//                DispatchQueue.main.async {
//                    self.publisher.send(success)
//                    if success {
//                        self.uiState = .success
//                    }
//                }
            }
        }
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            self.uiState = .success
        //            self.publisher.send(true)
        //        }
    }
}

//extension SignUpViewModel {
//    func homeView() -> some View {
//        return SignUpViewRouter.makeHomeView()
//    }
//}
