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
    
    var title: String = "Design iOS APP"
    var price: String = "180.000$"
    
    var photo = UIImage(named: "Me")!
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .frame(height: 140)
            .overlay(
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(project.title!)
                                .font(.custom("Roboto-Bold", size: 18))
                            Text(project.price!)
                                .font(.custom("Roboto-Light", size: 15))
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
                            Project.changeFavoriteStatus(context: viewContext, project: project)
                        }, label: {
                            Image("Star")
                                .foregroundColor(.blue)
                        })
                        .frame(width: 30, height: 30)
                        Button(action: {}, label: {
                            Image("Share")
                                .foregroundColor(.blue)
                        })
                        .frame(width: 30, height: 30)
                        Spacer()
                        
                        Button(action: {
                            Project.projectDone(context: viewContext, project: project)
                        }, label: {
                            Image("Done")
                                .foregroundColor(.blue)
                        })
                        .frame(width: 30, height: 30)
                        Button(action: {}, label: {
                            Image("Pencil")
                                .foregroundColor(.blue)
                        })
                        .frame(width: 30, height: 30)
                        Button(action: {
                            Project.deleteThisProject(context: viewContext, project: project)
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
