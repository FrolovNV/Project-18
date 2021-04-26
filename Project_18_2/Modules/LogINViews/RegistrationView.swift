//
//  RegistrationView.swift
//  Project 18
//
//  Created by Никита Фролов  on 05.04.2021.
//

import SwiftUI
import Combine
import CoreData

class RegistrationViewModel: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var firstName: String = ""
    @Published public var lastName: String = ""
    
    @Published private(set) var statusEmail: (placeholder: String, isWrong: Bool) = ("EMAIL", false)
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
    
    private var isFirstNameEmptyPublisher: AnyPublisher<Bool, Never> {
        $firstName
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { firstName in
                return firstName == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var isLastNameEmptyPublisher: AnyPublisher<Bool, Never> {
        $lastName
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { lastName in
                return lastName == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var allAreEmpty: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isEmailEmptyPublisher, isPasswordEmptyPublisher, isFirstNameEmptyPublisher, isLastNameEmptyPublisher)
            .map { emailFlag, passwordFlag, firstName, lastName in
                return !emailFlag && !passwordFlag && !firstName && !lastName
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
    
    init() {
        isChangedEmail
            .receive(on: RunLoop.main)
            .assign(to: \.statusEmail, on: self)
            .store(in: &cancellableSet)
        allAreEmpty
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    
    func registerNewUser(context: NSManagedObjectContext)-> Bool {
        guard let request = try? context.fetch(UserDatabase.shared.getUserByEmail(email: self.email)) else {
            return false
        }
        if !request.isEmpty {
            statusEmail.placeholder = "Email already exist"
            statusEmail.isWrong = true
            return false
        }
        let newUser = UserModels(context: context)
        newUser.email = self.email
        newUser.password = self.password
        newUser.firstName = self.firstName
        newUser.lastName = self.lastName
        do {
            try context.save()
        } catch {
            print(error)
        }
        return true
    }
}

struct RegistrationView: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: RegistrationViewModel = .init()
    
    
    var body: some View {
        VStack {
            HeaderLogIN(title: "REGISTER", navigationLeftButton: true)
                .frame(height: 200)
            Spacer()
            ScrollView {
                TextFieldForLogin(
                    text: $viewModel.email,
                    titleName: viewModel.statusEmail.placeholder,
                    imageName: "Mail",
                    placeHolderName: "Email",
                    flag: viewModel.statusEmail.isWrong
                )
                TextFieldWithSecurity(
                    text: $viewModel.password,
                    imageName: "Key",
                    titleName: "PASSWORD",
                    placeholder: "Password",
                    flag: false
                )
                TextFieldForLogin(
                    text: $viewModel.firstName,
                    titleName: "First Name",
                    imageName: "Person",
                    placeHolderName: "",
                    flag: false
                )
                TextFieldForLogin(
                    text: $viewModel.lastName,
                    titleName: "Last Name",
                    imageName: "Person",
                    placeHolderName: "",
                    flag: false
                )
                
                Button(action: {
                    if viewModel.registerNewUser(context: viewContext) {
                        userSettings.signIn(email: viewModel.email)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Register")
                        .font(.custom("Roboto-Medium", size: 16))
                        .foregroundColor(.white)
                })
                .disabled(!self.viewModel.isValid)
                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 5.5)
                        .foregroundColor(!self.viewModel.isValid ? .gray : .blue)
                )
            }
        }
        .navigationBarHidden(true)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
