//
//  ProjectHeaderViewModels.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 23.04.2021.
//

import Foundation
import SwiftUI
import Combine


class ProjectHeaderViewModel: ObservableObject{
    @Published public var title = "PROJECT"
    @Published public var flag = false
    @Published public var showSheetOfFilter = false
    @Published public var selectedFilterMode = 0
    @Published public var dragOffset: CGFloat = -400
    @Published public var opacityBackground = 0.0
}

