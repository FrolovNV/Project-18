//
//  ItemsOfTask.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 26.04.2021.
//

import SwiftUI

struct ItemsOfTask: View {
    
    var task : Tasks
    var title: String = "Design"
    var price: String = "300.00$"
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .frame(height: 100)
            .overlay(
                HStack {
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(task.title!)
                                    .font(.custom("Roboto-Bold", size: 18))
                            }
                            Text("\(task.priceDollar)")
                                .font(.custom("Roboto-Light", size: 15))
                        }
                        .padding()
                    }
                    Spacer()
                }
            )
            .transition(.slide)
            .animation(.default)
    }
}

//struct ItemsOfTask_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemsOfTask()
//    }
//}
