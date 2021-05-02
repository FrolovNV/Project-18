//
//  NavigationViewTabBar.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 08.04.2021.
//

import SwiftUI
import Combine

struct NavigationViewTabBar: View {
    
    @ObservedObject var tabBarViewModel: TabBarViewModel
    
    let imagesName = [["bag", "list.bullet"], ["tray", "circle.grid.3x3.fill"]]
    let namesOfCell = [["Project", "Today"], ["Inbox", "Profile"]]
    
    
    var body: some View {
        ZStack {
            Image("NavigationBar")
                .resizable()
                .foregroundColor(Color.init("DBlue"))
                .frame(width: UIScreen.main.bounds.width, height: 75)
            
            Button(action: {
                tabBarViewModel.showSheet.toggle()
                print(tabBarViewModel.navigationPosition)
            }, label: {
                Image(systemName: tabBarViewModel.colorAndName.1)
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .foregroundColor(tabBarViewModel.colorAndName.0)
                    )
                
            })
            .offset(y: -10)
            
            HStack {
                PairOfIcon(
                    imageName1: imagesName[0][0],
                    imageName2: imagesName[0][1],
                    name1: namesOfCell[0][0],
                    name2: namesOfCell[0][1],
                    selector: $tabBarViewModel.selected,
                    sectionCount: 2
                )
                Spacer()
                PairOfIcon(
                    imageName1: imagesName[1][0],
                    imageName2: imagesName[1][1],
                    name1: namesOfCell[1][0],
                    name2: namesOfCell[1][1],
                    selector: $tabBarViewModel.selected,
                    sectionCount: 4
                )
            }
        }
        .background(Color.clear)
    }
}

struct NavigationViewTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewTabBar(tabBarViewModel: TabBarViewModel())
    }
}
