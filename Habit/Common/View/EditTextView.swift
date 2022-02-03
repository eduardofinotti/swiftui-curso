//
//  EditTextView.swift
//  Habit
//
//  Created by Eduardo Finotti on 10/01/22.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String

    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
                    .autocapitalization(.none)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
                    .autocapitalization(.none)
            }
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){ value in
            VStack {
                EditTextView(text: .constant("sdsdsd"),
                             placeholder: "E-mail",
                             error: "Campo inválido",
                             failure: "a@a.com".count < 3)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(value)
        }
    }
}
