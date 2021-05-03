//
//  ContentOfMainNavigationView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import SwiftUI

struct ContentOfMainNavigationView: View {
    @EnvironmentObject var tabBarView: TabBarViewModel
    @EnvironmentObject var taskHeaderViewModel: TaskHeaderViewModel
    @EnvironmentObject var projectHeaderViewModel: ProjectHeaderViewModel
    
    var body: some View {
        NavigationView {
            switch tabBarView.selected {
            case 1:
                ListItemBackground(headerViewModel: self.projectHeaderViewModel)
                    .navigationBarHidden(true)
                    .environmentObject(taskHeaderViewModel)
            case 1...3:
                Text("Not ready")
            case 4:
                SettingsView(showSheet: $tabBarView.showSheet)
            default:
                Text("Not ready")
            }
        }
        .navigationViewStyle(DefaultNavigationViewStyle())
    }
}

struct ContentOfMainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentOfMainNavigationView()
    }
}
