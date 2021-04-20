//
//  AddProjectView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import SwiftUI

struct AddProjectView: View {
    
    @Binding var show: Bool
    @State var title: String = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15.0)
            .foregroundColor(.white)
            .frame(height: 300)
            .overlay(
                VStack {
                    HStack {
                        Button(action: {
                            show.toggle()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        })
                        Spacer()
                        Text("New Project")
                            .font(.custom("Roboto-Medium", size: 20))
                        
                        Spacer()
                        Button(action: {
                            
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
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(show: .constant(true))
    }
}
