//
//  LogInView.swift
//  Project 18
//
//  Created by Никита Фролов  on 30.03.2021.
//

import SwiftUI
import Combine
import CoreData


class LogInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published public var statusEmail: (String, Bool) = ("EMAIL", false)
    @Published public var statusPassword: (String, Bool) = ("PASSWORD", false)
    @Published public var isValid: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                return email == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var sameAreEmpty: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailEmptyPublisher, isPasswordEmptyPublisher)
            .map { emailFlag, passwordFlag in
                return !emailFlag && !passwordFlag
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        sameAreEmpty
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    
    func checkUser(context:  NSManagedObjectContext)-> Bool {
        let request = try! context.fetch(UserModels.getAllUsers())
        let res = request.first{$0.email == self.email}
        if res == nil {
            statusEmail.0 = "EMAIL ERROR"
            statusEmail.1 = true
            return false
        }
        if res?.password != self.password {
            statusPassword.0 = "WRONG PASSWORD"
            statusPassword.1 = true
            return false
        }
        
        return true
    }
    
}

struct LogInView: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: UserModels.getAllUsers()) var user: FetchedResults<UserModels>
    
    @State private var emailText = ""
    @State private var passwordText = ""
    
    @State private var alertOfEmail = false
    @State private var alertOfPassword = false
    @State private var titleOfEmail = "EMAIL"
    @State private var titleOfPassword = "PASSWORD"
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    @StateObject var viewModel: LogInViewModel = .init()
    
    var body: some View {
        
        VStack {
            HeaderLogIN(title: "PROJECT 18", navigationLeftButton: false)
                .frame(height: 200)
            Spacer()
            ScrollView {
                TextFieldForLogin(
                    text: $viewModel.email,
                    titleName: viewModel.statusEmail.0,
                    imageName: "Mail",
                    placeHolderName: "EMAIL",
                    flag: viewModel.statusEmail.1
                )
                TextFieldWithSecurity(
                    text: $viewModel.password,
                    imageName: "Key",
                    titleName: viewModel.statusPassword.0,
                    placeholder: "Password",
                    flag: viewModel.statusPassword.1
                )
                Button(action: {
                    if viewModel.checkUser(context: viewContext) {
                        userSettings.signIn(email: viewModel.email)
                    }
                }, label: {
                    Text("Log In")
                        .font(.custom("Roboto-Medium", size: 16))
                        .foregroundColor(.white)
                })
                .disabled(!self.viewModel.isValid)
                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 5.5)
                        .foregroundColor(!self.viewModel.isValid ? .gray : .blue)
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
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
