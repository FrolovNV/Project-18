//
//  AddProjectView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import SwiftUI

struct AddProjectView: View {
    @EnvironmentObject var tabBarView: TabBarViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @State var title: String = ""
    
    var body: some View {
        if (tabBarView.showSheet) && (tabBarView.navigationPosition == .createProject){
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
                                    Project.addNewProject(context: viewContext, title: title, price: "0.00$")
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
            .transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            .animation(.default)
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}
