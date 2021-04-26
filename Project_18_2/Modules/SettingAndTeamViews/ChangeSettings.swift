//
//  ChangeSettings.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI

struct ChangeSettings: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var changeEnd: Bool
    @State var user: UserModels
    
    @State var image = UIImage(named: "Person")!
    @State var firstName: String = ""
    @State var lastName: String  = ""
    @State var email: String = ""
    @State var mobile: String = ""
    
    @State var showImagePicker = false
    
    init(user: UserModels, changeEnd: Binding<Bool>) {
        self._user = State(initialValue: user)
        if let data = user.image {
            if let uiImage = UIImage(data: data) {
                self._image = State(initialValue: uiImage)
            }
        }
        self._firstName = State(initialValue: user.firstName)
        self._lastName = State(initialValue: user.lastName)
        self._email = State(initialValue: user.email)
        if let mobile = user.mobile {
            self._mobile = State(initialValue: mobile)
        }
        self._changeEnd = changeEnd
    }
    
    var body: some View {
        VStack {
            Button(action: {
                self.showImagePicker.toggle()
            }, label: {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .padding()
            })
            TextFieldForLogin(
                text: $firstName,
                titleName: "First Name",
                imageName: "",
                placeHolderName: firstName,
                flag: false
            )
            TextFieldForLogin(
                text: $lastName,
                titleName: "Last Name",
                imageName: "",
                placeHolderName: lastName,
                flag: false
            )
            TextFieldForLogin(
                text: $mobile,
                titleName: "Mobile number",
                imageName: "",
                placeHolderName: mobile,
                flag: false
            )
            
            Button(action: {
                let png = image.pngData()
                self.user.image = png
                self.user.firstName = self.firstName
                self.user.lastName = self.lastName
                self.user.email = self.email
                self.user.mobile = self.mobile
                do {
                    try viewContext.save()
                }
                catch {
                    
                }
                self.changeEnd.toggle()
            }, label: {
                Text("Save Changes")
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
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(isShowSheet: self.$showImagePicker, image: self.$image)
        }
    }
}

//struct ChangeSettings_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeSettings()
//    }
//}
