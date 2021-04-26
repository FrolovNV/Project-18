//
//  ListItemBackground.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI


struct ListItemBackground: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(fetchRequest: ProjectDatabase.shared.getAllUsersProjects()) var fetchProjects
    
    private var projects: [Project] {
        if headerViewModel.selectedFilterMode == 0 {
            return fetchProjects.sorted { $0.title! < $1.title! }
        } else if headerViewModel.selectedFilterMode == 1 {
            let favoriteOnly = fetchProjects.filter{$0.favorite}
            return favoriteOnly.sorted { $0.title! < $1.title! }
        } else if headerViewModel.selectedFilterMode == 2 {
            return fetchProjects.sorted { $0.creatingDate > $1.creatingDate }
        } else if headerViewModel.selectedFilterMode == 3 {
            let complitedTask = fetchProjects.filter {$0.complitionDate != nil}
            return complitedTask.sorted { $0.complitionDate! > $1.complitionDate! }
        }
        return fetchProjects.map { $0 }
    }
    
    @ObservedObject var headerViewModel: ProjectHeaderViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderProjectView(viewModel: headerViewModel)
                    .offset(y: 10)
                    .frame(height: 100)
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(projects) { project in
                            ListItem(project: project)
                                .padding()
                        }
                    }
                }
            }
        }
        .onAppear {
            self.tabBarViewModel.navigationPosition = .createProject
        }
        .background(Color.gray.opacity(0.15))
        .ignoresSafeArea(.all)
    }
}

struct ListItemBackground_Previews: PreviewProvider {
    static var previews: some View {
        ListItemBackground(headerViewModel: ProjectHeaderViewModel())
    }
}
