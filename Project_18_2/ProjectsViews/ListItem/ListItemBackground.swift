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
    
    @FetchRequest(fetchRequest: Project.getAllUsersProjects()) var fetchProjects
    
//    @State var project: [Project]
    
    @ObservedObject var headerViewModel: ProjectHeaderViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderProjectView(viewModel: headerViewModel)
                    .offset(y: 10)
                    .frame(height: 100)
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(fetchProjects) { project in
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
        .onReceive(self.headerViewModel.$selectedFilterMode, perform: { _ in
            if headerViewModel.selectedFilterMode == 0 {
                self.fetchProjects.sorted{$0.title! < $1.title!}
            } else if headerViewModel.selectedFilterMode == 1 {
        
            }
        })
        .background(Color.gray.opacity(0.15))
        .ignoresSafeArea(.all)
    }
}

struct ListItemBackground_Previews: PreviewProvider {
    static var previews: some View {
        ListItemBackground(headerViewModel: ProjectHeaderViewModel())
    }
}
