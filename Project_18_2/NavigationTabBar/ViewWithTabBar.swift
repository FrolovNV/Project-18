//
//  ViewWithTabBar.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 08.04.2021.
//

import SwiftUI

struct ViewWithTabBar: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Text")
            Spacer()
            NavigationViewTabBar()
        }
        .ignoresSafeArea(.all)
    }
}

struct ViewWithTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ViewWithTabBar()
    }
}
