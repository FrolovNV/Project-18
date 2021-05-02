//
//  ListItem.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI

struct ListItem: View {
    @Environment(\.managedObjectContext) private var viewContext
    var project: Project
    @State var favorite: Bool
    @State var complited: Bool
    let photo = UIImage(named: "Me")!
    
    init(project: Project) {
        self.project = project
        self._favorite = State(initialValue: project.favorite)
        self._complited = State(initialValue: project.complitionDate == nil ? false : true)
    }
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .frame(height: 140)
            .overlay(
                VStack {
                    HStack {
                        NavigationLink(destination: ListOfTask(project: project)) {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(project.title!)
                                        .font(.custom("Roboto-Bold", size: 18))
                                    if self.complited {
                                        Image("Done")
                                            .foregroundColor(.green)
                                    }
                                }
                                Text(project.price!)
                                    .font(.custom("Roboto-Light", size: 15))
                            }
                        }
                        Spacer()
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 35, height: 35)
                            .cornerRadius(5.0)
                            .clipped()
                    }
                    .padding()
                    Divider()
                        .foregroundColor(.black)
                    HStack {
                        Button(action: {
                            favorite.toggle()
                            ProjectDatabase.shared.changeFavoriteStatus(context: viewContext, project: project)
                        }, label: {
                            Image("Star")
                                .foregroundColor(self.favorite ? .yellow : .blue)
                        })
                        .frame(width: 30, height: 30)
                        Button(action: {}, label: {
                            Image("Share")
                                .foregroundColor(.blue)
                        })
                        .frame(width: 30, height: 30)
                        Spacer()
                        
                        Button(action: {
                            self.complited.toggle()
                            ProjectDatabase.shared.projectDone(context: viewContext, project: project)
                        }, label: {
                            Image("Done")
                                .foregroundColor(self.complited ? .gray : .blue)
                        })
                        .disabled(self.complited)
                        .frame(width: 30, height: 30)
                        Button(action: {}, label: {
                            Image("Pencil")
                                .foregroundColor(.blue)
                        })
                        .frame(width: 30, height: 30)
                        Button(action: {
                            ProjectDatabase.shared.deleteThisProject(context: viewContext, project: project)
                        }, label: {
                            Image("Trash")
                                .foregroundColor(Color("RedError"))
                        })
                        .frame(width: 30, height: 30)
                    }
                    .padding(.horizontal, 10)
                    .frame(height: 40)
                }
                .padding(.horizontal, 10)
            )
            .transition(.slide)
            .animation(.default)
    }
}

//struct ListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ListItem()
//            .background(Color.gray.opacity(0.25))
//    }
//}
