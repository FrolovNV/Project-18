//
//  TabBarViewModel.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import Foundation
import SwiftUI
import Combine


enum NavigationLinkViews {
    case createProject
    case createTask
    case doneTask
    case settingsMain
}

class TabBarViewModel: ObservableObject {
    @Published var selected: Int = 1
    @Published var selectedIntoView: Int = 1
    @Published var showSheet: Bool = false
    @Published var _currentNavigationPosition: NavigationLinkViews = .createProject
    var navigationPosition: NavigationLinkViews {
        get {
            _currentNavigationPosition
        }
        set {
            guard showSheet == false else {
                return
            }
            _currentNavigationPosition = newValue
        }
    }
    
    
    @Published var colorAndName: (Color, String) = (
        Color("Orange"),
        "plus"
    )
    
    private var intoTabBar: AnyPublisher<Int, Never> {
        $selected
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .map { value in
                return value
            }
            .eraseToAnyPublisher()
    }
    
    private var intoView: AnyPublisher<Int, Never> {
        $selectedIntoView
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .map { value in
                return value
            }
            .eraseToAnyPublisher()
    }
    
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

