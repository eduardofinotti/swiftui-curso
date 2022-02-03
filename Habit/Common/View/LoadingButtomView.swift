//
//  LoadingButtomView.swift
//  Habit
//
//  Created by Eduardo Finotti on 10/01/22.
//

import SwiftUI

struct LoadingButtomView: View {
    
    var action: () -> Void
    var text: String
    var showProgress: Bool = false
    var disabled: Bool = false
    
    var body: some View {
        ZStack {
            Button (action: {
                action()
            }, label: {
                Text(showProgress ? "" : text)
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("lightOrange") : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
            }).disabled(disabled || showProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}

struct LoadingButtomView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack{
                LoadingButtomView(action: {
                    print("pressionou")
                },
                text: "Entrar",
                showProgress: true,
                disabled: true)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
        }
    }
}
