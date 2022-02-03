//
//  SplashView.swift
//  Habit
//
//  Created by Eduardo Finotti on 07/01/22.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
        
    var body: some View {
        Group {
            switch viewModel.uiState {
                case .loading:
                    loadingView() // carregar tela atual com estado
                case .goToSignInScreen:
                    viewModel.signInView() // ir para outra tela
                case .goToHomeScreen:
                    Text("Carregar tela principal...")
                case .error(let msg):
                    loadingView(error: msg) // carregar tela atual com estado
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

// forma 1 - Comaptilhamento de objetos
struct LoadingView: View {
    var body: some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
        }
    }
}

// forma 2 - variaveis em extensoes
extension SplashView {
    var loading: some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
        }
    }
}

// forma 3 - funções em extensoes - passa parametro
extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Erro"), message: Text(error), dismissButton: .default(Text("Ok")){
                            
                        })
                    })
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SplashViewModel()
        SplashView(viewModel: viewModel)
    }
}
