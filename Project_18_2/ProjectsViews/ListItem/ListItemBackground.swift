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
    
    @FetchRequest(fetchRequest: Project.getAllUsersProjects()) var projects
    
    @ObservedObject var headerViewModel: ProjectHeaderViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderProjectView(viewModel: headerViewModel)
                    .offset(y: 10)
                    .frame(height: 100)
                Text("\(projects.count)")
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
