//
//  UserDefaultsSettings.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import Foundation
import SwiftUI

class UserDefaultsSettings: ObservableObject {
    @Published var userLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")
    @Published var userLogin = UserDefaults.standard.string(forKey: "userLogin")
}
