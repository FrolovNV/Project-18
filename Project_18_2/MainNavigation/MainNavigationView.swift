//
//  MainNavigationView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI

struct MainNavigationView: View {
    
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @StateObject var tabBarView = TabBarViewModel()
    
    var body: some View {
        VStack {
            switch tabBarView.selected {
            case 1...3:
                Text("Not ready")
            case 4:
                SettingsView(showSheet: $tabBarView.showSheet)
            default:
                Text("Not ready")
            }
            Spacer()
            NavigationViewTabBar(tabBarViewModel: tabBarView)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all)
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
