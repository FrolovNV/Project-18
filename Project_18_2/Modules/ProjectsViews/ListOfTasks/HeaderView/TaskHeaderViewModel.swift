//
//  TaskHeaderViewModel.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 29.04.2021.
//

import Foundation
import SwiftUI
import Combine


class TaskHeaderViewModel: ObservableObject {
    @Published public var title = "PROJECT"
    @Published public var showAction = false
    @Published public var project: Project?
}
