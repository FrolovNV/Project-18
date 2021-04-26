//
//  TextFieldWithSecurity.swift
//  Project 18
//
//  Created by Никита Фролов  on 05.04.2021.
//

import SwiftUI

struct TextFieldWithSecurity: View {
    
    @Binding var text: String
    var imageName: String
    var titleName: String
    var placeholder: String
    var flag: Bool
    @State var showPassword = false
    
    var body: some View {
        HStack {
            Image(imageName)
                .foregroundColor(flag ? Color.init("RedError") : .blue)
            VStack(alignment: .leading) {
                Text(titleName)
                    .font(.custom("Roboto-Medium", size: 10))
                    .foregroundColor(flag ? Color.init("RedError") : .gray)
                HStack {
                    if showPassword {
                        TextField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("Robot-Medium", size: 18))
                    } else {
                        SecureField("Password", text: $text)
                            .font(.custom("Robot-Medium", size: 18))
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    Button(action: {
                        self.showPassword.toggle()
                    }, label: {
                        Image("Eye")
                            .imageScale(.large)
                            .foregroundColor(showPassword ? .blue : .gray)
                    })
                }
                .frame(height: 20)
                Divider()
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct TextFieldWithSecurity_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithSecurity(text: .constant("Password"), imageName: "Key", titleName: "PASSWORD", placeholder: "Password", flag: true)
    }
}
