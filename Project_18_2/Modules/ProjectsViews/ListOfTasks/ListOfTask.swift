//
//  ListOfTask.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import SwiftUI

struct ListOfTask: View {
    @EnvironmentObject var headerViewModel: ProjectHeaderViewModel
    @EnvironmentObject var taskViewModel: TaskHeaderViewModel
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    var project: Project
    var fetchTask: FetchRequest<Tasks>
    
    
    private var tasks: [Tasks] {
        print(fetchTask)
        return fetchTask.wrappedValue.map { $0 }
    }

    init(project: Project) {
        self.project = project
        self.fetchTask = FetchRequest(fetchRequest: TasksDatabase.shared.getAllTaskOfProject(project: project))
//        self._fetchTask = State(initialValue: FetchRequest(fetchRequest: TasksDatabase.shared.getAllTaskOfProject(project: project)))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 20)
                .foregroundColor(.clear)
            TaskHeaderView(viewModel: taskViewModel)
            LabelOfProjectWithActionsView(project: project)
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<tasks.count) { index in
                        ItemsOfTask(task: tasks[index])
                            .padding()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            self.taskViewModel.project = self.project
            self.tabBarViewModel.navigationPosition = .createTask
        }
        .background(Color.gray.opacity(0.15))
        .ignoresSafeArea(.all)
    }
}

//struct ListOfTask_Previews: PreviewProvider {
//    static var previews: some View {
//        ListOfTask()
//            .environmentObject(ProjectHeaderViewModel())
//    }
//}
