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
    @Published public var email = ""
    @Published public var password = ""
    
    @Published private(set) var statusEmail: (placeholder: String, isWrong: Bool) = ("EMAIL", false)
    @Published private(set) var statusPassword: (placeholder: String, isWrong: Bool) = ("PASSWORD", false)
    @Published private(set) var isValid: Bool = false
    
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
    
    private var isChangedEmail: AnyPublisher<(placeholder: String, isWrong: Bool), Never> {
        $email
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _ in
                return ("EMAIL", false)
            }
            .eraseToAnyPublisher()
    }
    
    private var isChangedPassword: AnyPublisher<(placeholder: String, isWrong: Bool), Never> {
        $password
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _ in
                return ("PASSWORD", false)
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
        isChangedEmail
            .receive(on: RunLoop.main)
            .assign(to: \.statusEmail, on: self)
            .store(in: &cancellableSet)
        isChangedPassword
            .receive(on: RunLoop.main)
            .assign(to: \.statusPassword, on: self)
            .store(in: &cancellableSet)
    }
    
    func checkUser(context:  NSManagedObjectContext)-> Bool {
        guard let request = try? context.fetch(UserModels.getUserByEmail(email: self.email)) else {
            return false
        }
        if request.isEmpty {
            statusEmail.placeholder = "EMAIL ERROR"
            statusEmail.isWrong = true
            return false
        }
        if request[0].password != self.password {
            statusPassword.placeholder = "WRONG PASSWORD"
            statusPassword.isWrong = true
            return false
        }
        return true
    }
    
}

struct LogInView: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var viewModel: LogInViewModel = .init()
    
    var body: some View {
        
        VStack {
            HeaderLogIN(title: "PROJECT 18", navigationLeftButton: false)
                .frame(height: 200)
            Spacer()
            ScrollView {
                TextFieldForLogin(
                    text: $viewModel.email,
                    titleName: viewModel.statusEmail.placeholder,
                    imageName: "Mail",
                    placeHolderName: "EMAIL",
                    flag: viewModel.statusEmail.isWrong
                )
                TextFieldWithSecurity(
                    text: $viewModel.password,
                    imageName: "Key",
                    titleName: viewModel.statusPassword.placeholder,
                    placeholder: "Password",
                    flag: viewModel.statusPassword.isWrong
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
