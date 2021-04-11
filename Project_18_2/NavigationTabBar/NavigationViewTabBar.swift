//
//  NavigationViewTabBar.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 08.04.2021.
//

import SwiftUI
import Combine

class TabBarViewModel: ObservableObject {
    @Published var selected: Int = 1
    
    @Published var colorOfButton: Color = Color.init("Orange")
    @Published var imageNameOfButton: String = "plus"
    
    @Published var colorAndName: (Color, String) = (
        Color.init("Orange"),
        "plus"
        )
    
    private var selectedPub: AnyPublisher<(Color, String), Never> {
        $selected
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .map { value in
                print(value)
                return self.changeColorAndImage(selected: value)
            }
            .eraseToAnyPublisher()
    }
    
    private func changeColorAndImage(selected: Int)->(Color, String) {
        switch selected {
        case 1:
            return (Color.init("Orange"), "plus")
        case 2...3:
            return (Color.init("LightGreen"), "checkmark")
        case 4:
            return (Color.init("LightGreen"), "pencil")
        default:
            return (Color.init("Orange"), "plus")
        }
    }
    
    init() {
        selectedPub
            .receive(on: DispatchQueue.main)
            .map{ value in
                print(value)
                return value
            }
            .assign(to: \.colorAndName, on: self)
    }
}

struct NavigationViewTabBar: View {
    
    @ObservedObject var tabBarViewModel = TabBarViewModel()
    
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

            
            Image(systemName: tabBarViewModel.colorAndName.1)
                .foregroundColor(.white)
                .imageScale(.large)
                .background(
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(tabBarViewModel.colorAndName.0)
                )
                .offset(y: -10)
            HStack {
                PairOfIcon(imageName1: imagesName[0][0], imageName2: imagesName[0][1], name1: namesOfCell[0][0], name2: namesOfCell[0][1], selector: $tabBarViewModel.selected, sectionCount: 2)
                Spacer()
                PairOfIcon(imageName1: imagesName[1][0], imageName2: imagesName[1][1], name1: namesOfCell[1][0], name2: namesOfCell[1][1], selector: $tabBarViewModel.selected, sectionCount: 4)
            }
            
        }
    }
}

struct NavigationViewTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewTabBar()
    }
}
