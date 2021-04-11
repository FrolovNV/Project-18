//
//  LogInView.swift
//  Project 18
//
//  Created by Никита Фролов  on 30.03.2021.
//

import SwiftUI

struct LogInView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: UserModels.getUserWithEmail()) var user: FetchedResults<UserModels>
    
    @State private var emailText = ""
    @State private var passwordText = ""
    
    @State private var alertOfEmail = false
    @State private var alertOfPassword = false
    @State private var titleOfEmail = "EMAIL"
    @State private var titleOfPassword = "PASSWORD"
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        
        VStack {
            HeaderLogIN(title: "PROJECT 18", navigationLeftButton: false)
                .frame(height: 200)
            Spacer()
            ScrollView {
                TextFieldForLogin(text: $emailText, titleName: titleOfEmail, imageName: "Mail", placeHolderName: "EMAIL", flag: alertOfEmail)
                TextFieldWithSecurity(text: $passwordText, imageName: "Key", titleName: titleOfPassword, placeholder: "Password", flag: alertOfPassword)
                Button(action: {
                    let currentUser = user.first{$0.email == emailText}
                    
                    if currentUser == nil {
                        titleOfEmail = "EMAIL ERROR"
                        alertOfEmail = true
                        return
                    }
                    if currentUser?.password != passwordText {
                        titleOfPassword = "WRONG PASSWORD"
                        alertOfPassword = true
                        return
                    }
                    showAlert = true
                    alertTitle = "Success"
                    alertMessage = "You have successfully logged in!"
                    
                    titleOfEmail = "EMAIL"
                    alertOfEmail = false
                    titleOfPassword = "PASSWORD"
                    alertOfPassword = false
                }, label: {
                    Text("Log In")
                        .font(.custom("Roboto-Medium", size: 16))
                        .foregroundColor(.white)
                })
                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 5.5)
                        .foregroundColor(.blue)
                )
                Spacer()
            }
            Text("Don't have an account?")
                .font(.custom("Roboto-Medium", size: 12))
                .foregroundColor(.gray)
            NavigationLink(destination: RegistrationView()) {
                Text("Register")
                    .font(.custom("Roboto-Medium", size: 15))
                    .foregroundColor(.blue)
                    .environment(\.managedObjectContext, viewContext)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Important message"),
                    message: Text("Wear sunscreen"),
                    dismissButton: .default(Text("Ok!"))
                )
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
