//
//  NavigationViewTabBar.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 08.04.2021.
//

import SwiftUI

struct NavigationViewTabBar: View {
    
    let width = UIScreen.main.bounds.width
    
    let imagesName = [["bag", "list.bullet"], ["tray", "circle.grid.3x3.fill"]]
    let namesOfCell = [["Project", "Today"], ["Inbox", "Profile"]]
    
    @State var selector = 1
    
    var body: some View {
        ZStack {
            Image("NavigationBar")
                .resizable()
                .foregroundColor(Color.init("DBlue"))
                .frame(width: width, height: 65)

            
            Image(systemName: "plus")
                .foregroundColor(.white)
                .imageScale(.large)
                .background(
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.init("LightGreen"))
                )
                .offset(y: -10)
            HStack {
                PairOfIcon(imageName1: imagesName[0][0], imageName2: imagesName[0][1], name1: namesOfCell[0][0], name2: namesOfCell[0][1], selector: $selector, sectionCount: 2)
                Spacer()
                PairOfIcon(imageName1: imagesName[1][0], imageName2: imagesName[1][1], name1: namesOfCell[1][0], name2: namesOfCell[1][1], selector: $selector, sectionCount: 4)
            }
            
        }
    }
}

struct NavigationViewTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewTabBar()
    }
}
