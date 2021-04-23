//
//  MainNavigationView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI

struct MainNavigationView: View {
    
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @StateObject var projectHeaderViewModel = ProjectHeaderViewModel()
    @StateObject var tabBarView = TabBarViewModel()
    
    @State var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                NavigationView {
                    switch tabBarView.selected {
                    case 1:
                        ListItemBackground(headerViewModel: self.projectHeaderViewModel)
                            .navigationBarHidden(true)
                    case 1...3:
                        Text("Not ready")
                    case 4:
                        SettingsView(showSheet: $tabBarView.showSheet)
                    default:
                        Text("Not ready")
                    }
                }
                .ignoresSafeArea(.all, edges: [.top, .horizontal, .bottom])
                Spacer()
                NavigationViewTabBar(tabBarViewModel: tabBarView)
                    .ignoresSafeArea(.all, edges: [.top, .horizontal, .bottom])
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 5)
                    .foregroundColor(Color("DBlue"))
                    .ignoresSafeArea(.all, edges: [.top, .horizontal, .bottom])
            }
            .ignoresSafeArea(.all, edges: [.top, .horizontal, .bottom])
            
            Color.black.opacity(tabBarView.showSheet || projectHeaderViewModel.showSheetOfFilter ? 0.3 : 0)
                .onTapGesture {
                    if tabBarView.showSheet {
                        withAnimation(.easeInOut(duration: 0.1)){
                            tabBarView.showSheet.toggle()
                        }
                    }
                    if projectHeaderViewModel.showSheetOfFilter {
                        withAnimation(.easeInOut(duration: 0.1)){
                            projectHeaderViewModel.showSheetOfFilter.toggle()
                        }
                    }
                }
                .ignoresSafeArea(.all, edges: [.top, .horizontal, .bottom])
            
            
            FilterView(headerViewModel: self.projectHeaderViewModel)
                .ignoresSafeArea(.all, edges: [.top, .horizontal, .bottom])
            AddProjectView()
        }
        .environmentObject(userSettings)
        .environmentObject(tabBarView)
        .navigationBarHidden(true)
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
