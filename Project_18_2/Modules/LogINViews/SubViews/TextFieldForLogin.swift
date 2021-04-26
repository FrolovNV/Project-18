//
//  TextFieldWithSecurity.swift
//  Project 18
//
//  Created by Никита Фролов  on 05.04.2021.
//

import SwiftUI

struct TextFieldForLogin: View {
    
    @Binding var text: String
    var titleName: String
    var imageName: String
    var placeHolderName: String
    var flag: Bool
    
    var body: some View {
        HStack {
            Image(imageName)
                .foregroundColor(flag ? Color.init("RedError") : .blue)
            VStack(alignment: .leading) {
                Text(titleName)
                    .font(.custom("Roboto-Medium", size: 10))
                    .foregroundColor(flag ? Color.init("RedError") : .gray)
                TextField(placeHolderName, text: $text)
                    .font(.custom("Robot-Medium", size: 18))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Divider()
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct TextFieldForLogin_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldForLogin(text: .constant("Name"), titleName: "LOGIN", imageName: "Mail", placeHolderName: "EMAIL", flag: true)
    }
}
