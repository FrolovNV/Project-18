//
//  LabelOfProjectWithActionsView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 29.04.2021.
//

import SwiftUI

struct LabelOfProjectWithActionsView: View {
    @State var titleName: String = "Title of Project"
    @State var creatingData: String = "23.02.2000"
    
    var project: Project
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(DateFormatterToAndFrom.shared.getStringFromDate(date: project.creatingDate))
                    .font(.custom("Roboto-Light", size: 16))
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                HStack {
                    Text(project.title!)
                        .font(.custom("Roboto-Bold", size: 25))
                        .padding(.leading, 20)
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image("ActionTask")
                            .foregroundColor(.gray)
                            .padding(.trailing, 7)
                    })
                }
            }
            
            Spacer()
        }
    }
}

//struct LabelOfProjectWithActionsView_Previews: PreviewProvider {
//    static var previews: some View {
////        LabelOfProjectWithActionsView()
//    }
//}
