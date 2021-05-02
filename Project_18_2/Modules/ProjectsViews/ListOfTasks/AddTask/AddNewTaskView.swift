//
//  AddNewTaskView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import SwiftUI

struct AddNewTaskView: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @ObservedObject var tabBarView: TabBarViewModel
    @EnvironmentObject var taskHeader: TaskHeaderViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var title: String = ""
    @State var cost1: String = ""
    @State var cost2: String = ""
    
    var body: some View {
        if(tabBarView.navigationPosition == .createTask) && (tabBarView.showSheet) {
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(.white)
                .frame(height: 340)
                .overlay(
                    VStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 5.0)
                            .frame(width: 50, height: 5)
                            .foregroundColor(.gray)
                        HStack {
                            Button(action: {
                                self.tabBarView.showSheet.toggle()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.red)
                            })
                            Spacer()
                            Text("NEW TASK")
                                .font(.custom("Roboto-Bold", size: 18))
                            Spacer()
                            Button(action: {
                                self.tabBarView.showSheet.toggle()
                                
                                ProjectDatabase.shared.addNewIntoProjectTask(context: viewContext, project: taskHeader.project!, person: userSettings.user!, title: title)
                                
                                self.title = ""
                                self.cost1 = ""
                                self.cost2 = ""
                                
                            }, label: {
                                Text("Create")
                            })
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Task Name")
                                .font(.custom("Roboto-Light", size: 18))
                                .foregroundColor(.gray)
                            TextField(title, text: $title)
                                .font(.custom("Roboto-Medium", size: 20))
                                .foregroundColor(.black)
                            Divider()
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Cost 1")
                                .font(.custom("Roboto-Light", size: 18))
                                .foregroundColor(.gray)
                            TextField("$ " + cost1, text: $cost1)
                                .font(.custom("Roboto-Medium", size: 20))
                                .foregroundColor(.black)
                                .keyboardType(.decimalPad)
                            Divider()
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Cost 2")
                                .font(.custom("Roboto-Light", size: 18))
                                .foregroundColor(.gray)
                            TextField("$ " + cost1, text: $cost1)
                                .font(.custom("Roboto-Medium", size: 20))
                                .foregroundColor(.black)
                                .keyboardType(.decimalPad)
                            Divider()
                        }
                    }
                    .padding()
                )
        }
    }
}

//struct AddNewTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewTaskView()
//    }
//}
