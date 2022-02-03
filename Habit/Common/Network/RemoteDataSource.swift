//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Eduardo Finotti on 25/01/22.
//

import Foundation
import Combine

class RemoteDataSource {
    
    // padrao singleton
    // apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init(){
        
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promisse in
            
            WebService.call(path: .login, params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
            ]) { result in
                switch result {
                    case .failure(let error, let data):
                        if let data = data {
                            
                            if error == .unauthorized {
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                                promisse(.failure(AppError.response(message: response?.detail.message ?? "Erro no servidor.")))
                            }
                            
                        }
                        break
                    case .success(let data):
                        print(String(data: data, encoding: .utf8))
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInResponse.self, from: data)
                        
                        guard let response = response else {
                            print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                            return
                        }
                        
                        promisse(.success(response))
                        break
                    }
            }
        }
    }
    
}
