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
        NavigationView {
            VStack {
                SettingsView(showSheet: $tabBarView.showSheet)
                Spacer()
                NavigationViewTabBar(tabBarViewModel: tabBarView)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all)
        }
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
