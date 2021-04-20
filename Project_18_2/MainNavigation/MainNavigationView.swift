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
    
    @State var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch tabBarView.selected {
                case 1:
                    ListItemBackground()
                case 1...3:
                    Text("Not ready")
                case 4:
                    SettingsView(showSheet: $tabBarView.showSheet)
                default:
                    Text("Not ready")
                }
                Spacer()
                NavigationViewTabBar(tabBarViewModel: tabBarView)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 5)
                    .foregroundColor(Color("DBlue"))
            }
            
            Color.black.opacity(tabBarView.showSheet ? 0.3 : 0.0)
            VStack {
                Spacer()
                AddProjectView(show: $tabBarView.showSheet)
                    .offset(y: dragOffset)
            }
            .opacity(tabBarView.showSheet ? 0.3 : 0.0)
        }
        .ignoresSafeArea(.all, edges: [.top, .horizontal, .bottom])
        .navigationBarHidden(true)
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
