//
//  AddProjectView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import SwiftUI

struct AddProjectView: View {
    @ObservedObject var tabBarView: TabBarViewModel
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @Environment(\.managedObjectContext) private var viewContext
    @State var title: String = ""
    
    var body: some View {
        if (tabBarView.navigationPosition == .createProject) && (tabBarView.showSheet){
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 15.0)
                    .foregroundColor(.white)
                    .frame(height: 300)
                    .overlay(
                        VStack {
                            HStack {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.1)){
                                        tabBarView.showSheet.toggle()
                                    }
                                }, label: {
                                    Text("Cancel")
                                        .foregroundColor(.red)
                                })
                                Spacer()
                                Text("New Project")
                                    .font(.custom("Roboto-Medium", size: 20))
                                
                                Spacer()
                                Button(action: {
                                    tabBarView.showSheet.toggle()
                                    ProjectDatabase.shared.addNewProject(
                                        context: viewContext,
                                        user: userSettings.user!,
                                        title: title,
                                        price: "0.00$"
                                    )
                                    title = ""
                                }, label: {
                                    Text("Create")
                                        .foregroundColor(.blue)
                                })
                            }
                            .padding()
                            
                            VStack(alignment: .leading) {
                                Text("Project Name")
                                    .font(.custom("Roboto-Light", size: 18))
                                    .foregroundColor(.gray)
                                TextField(title, text: $title)
                                    .font(.custom("Roboto-Medium", size: 20))
                                    .foregroundColor(.black)
                                Divider()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .padding()
                            Spacer()
                        }
                )
            }
            .transition(.move(edge: .bottom))
            .animation(.default)
            .ignoresSafeArea(.container, edges: [.top, .horizontal, .bottom])
        }
    }
}

//struct AddProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProjectView()
//    }
//}
