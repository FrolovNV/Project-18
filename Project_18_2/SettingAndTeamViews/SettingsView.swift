//
//  SettingsView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @Binding var showSheet: Bool
    @State var user: UserModels?
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        VStack {
            HeaderSettings(
                imageName: UIImage(data: user?.image ?? Data()),
                firstName: user?.firstName ?? "",
                lastName: user?.lastName ?? "",
                email: user?.lastName ?? "",
                mobileNumber: user?.mobile ?? ""
            )
                .frame(height: 200)
            Spacer()
        }
        .onAppear {
            let res = try! self.viewContext.fetch(UserModels.getUserByEmail(email: self.userSettings.userLogin!))
            self.user = res[0]
        }
        .sheet(isPresented: $showSheet) {
            ChangeSettings(user: user!, changeEnd: $showSheet)
        }
    }
}
