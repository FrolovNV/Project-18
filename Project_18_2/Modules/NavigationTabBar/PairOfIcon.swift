//
//  PairOfIcon.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 08.04.2021.
//

import SwiftUI

struct PairOfIcon: View {
    
    var imageName1: String
    var imageName2: String
    var name1: String
    var name2: String
    
    @Binding var selector: Int
    var sectionCount: Int
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.selector = sectionCount - 1
                }
            }) {
                IconForTabBar(imageName: imageName1, name: name1, flag: selector == sectionCount - 1)
            }
            .padding(.trailing, 5)
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.selector = sectionCount
                }
            }) {
                IconForTabBar(imageName: imageName2, name: name2, flag: selector == sectionCount)
            }
        }
        .padding()
    }
}

struct PairOfIcon_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init("DBlue")
            PairOfIcon(imageName1: "bag", imageName2: "list.bullet", name1: "Project", name2: "Today", selector: .constant(1), sectionCount: 2)
        }
    }
}
