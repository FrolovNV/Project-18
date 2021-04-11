//
//  RegistrationView.swift
//  Project 18
//
//  Created by Никита Фролов  on 05.04.2021.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: UserModels.getUserWithEmail()) var user: FetchedResults<UserModels>
    @Environment(\.presentationMode) var presentationMode
    
    @State var emailText: String = ""
    @State var password: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    @State var titleEmail = "EMAIL"
    @State var titlePassword = "PASSWORD"
    @State var titleFirstName = "First Name"
    @State var titleLastName = "Last Name"
    @State var flagEmail = false
    
    
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    
    var body: some View {
        VStack {
            HeaderLogIN(title: "REGISTER", navigationLeftButton: true)
                .frame(height: 200)
            Spacer()
            ScrollView {
                TextFieldForLogin(
                    text: $emailText,
                    titleName: titleEmail,
                    imageName: "Mail",
                    placeHolderName: "Email",
                    flag: flagEmail
                )
                TextFieldWithSecurity(
                    text: $password,
                    imageName: "Key",
                    titleName: titlePassword,
                    placeholder: "Password",
                    flag: false
                )
                TextFieldForLogin(
                    text: $firstName,
                    titleName: titleFirstName,
                    imageName: "Person",
                    placeHolderName: "",
                    flag: false
                )
                TextFieldForLogin(
                    text: $lastName,
                    titleName: titleLastName,
                    imageName: "Person",
                    placeHolderName: "",
                    flag: false
                )
                
                Button(action: {
                    if (emailText.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
                        showAlert.toggle()
                        alertTitle = "Fields"
                        alertMessage = "Fields must'n be empty"
                        return
                    }
                    let findUser = user.first{$0.email == emailText}
                    if findUser != nil {
                        titleEmail = "Email already exist"
                        flagEmail = true
                        return
                    }
                    let newUser = UserModels(context: self.viewContext)
                    newUser.email = emailText
                    newUser.password = password
                    newUser.firstName = firstName
                    newUser.lastName = lastName
                    do {
                        try self.viewContext.save()
                    } catch {
                        print(error)
                    }
                    alertTitle = "Ready!"
                    alertMessage = "You have registered"
                    showAlert = true
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Register")
                        .font(.custom("Roboto-Medium", size: 16))
                        .foregroundColor(.white)
                })
                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 5.5)
                        .foregroundColor(.blue)
                )
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("Ok!"))
            )
        }
        .navigationBarHidden(true)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
