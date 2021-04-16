//
//  SettingsView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI
import Combine
import CoreData


final class SettingsViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Published private var user: UserModels?
    
    var image: UIImage {
        get {
            guard let imageData = user?.image else {return UIImage(named: "Person")!}
            guard let uiImage = UIImage(data: imageData) else {return UIImage(named: "Person")!}
            return uiImage
        }
    }
    var firstName: String {
        get {
            return user?.firstName ?? ""
        }
    }
    var lastName: String {
        get {
            return user?.lastName ?? ""
        }
    }
    var email: String {
        get {
            return user?.email ?? ""
        }
    }
    var mobileNumber: String {
        get {
            return user?.mobile ?? ""
        }
    }
    
    func getUser(_ email: String) {
        let res = try! viewContext.fetch(UserModels.getUserByEmail(email: email))
        user = res[0]
    }
    
}

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @Binding var showSheet: Bool
    @State var user: UserModels?
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: SettingsViewModel = .init()
    
    
    var body: some View {
        VStack {
            HeaderSettings(
                image: viewModel.image,
                firstName: viewModel.firstName,
                lastName: viewModel.lastName,
                email: viewModel.email,
                mobileNumber: viewModel.mobileNumber
            )
            .frame(height: 200)
            Spacer()
            HStack {
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "userLoggedIn")
                    UserDefaults.standard.set("", forKey: "userLogin")
                    self.userSettings.userLogin = ""
                    self.userSettings.userLoggedIn.toggle()
                }, label: {
                    Text("Sign Out")
                        .font(.custom("Roboto-Bold", size: 25))
                        .foregroundColor(Color("RedError"))
                })
                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.getUser(userSettings.userLogin!)
        }
        .sheet(isPresented: $showSheet) {
            ChangeSettings(user: user!, changeEnd: $showSheet)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSheet: .constant(false))
    }
}
