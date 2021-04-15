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
    @Published var showSheet: Bool = false
    
    @Published var colorAndName: (Color, String) = (
        Color("Orange"),
        "plus"
    )
    
    private var selectedPub: AnyPublisher<(Color, String), Never> {
        $selected
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .map { value in
                return self.changeColorAndImage(selected: value)
            }
            .eraseToAnyPublisher()
    }
    
    private func changeColorAndImage(selected: Int)->(Color, String) {
        switch selected {
        case 1:
            return (Color("Orange"), "plus")
        case 2...3:
            return (Color("LightGreen"), "checkmark")
        case 4:
            return (Color("LightGreen"), "pencil")
        default:
            return (Color("Orange"), "plus")
        }
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        selectedPub
            .receive(on: DispatchQueue.main)
            .map{ value in
                return value
            }
            .assign(to: \.colorAndName, on: self)
            .store(in: &cancellableSet)
    }
}

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
    }
}

struct NavigationViewTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewTabBar(tabBarViewModel: TabBarViewModel())
    }
}
