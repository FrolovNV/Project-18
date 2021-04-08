//
//  NavigationLoIn.swift
//  Project 18
//
//  Created by Никита Фролов  on 30.03.2021.
//

import SwiftUI

struct NavigationLogIn: View {
    @Environment(\.managedObjectContext) private var viewContext

    
    var body: some View {
        NavigationView {
            LogInView()
                .environment(\.managedObjectContext, viewContext)
                .navigationBarHidden(true)
        }
    }
}

struct NavigationLoIn_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLogIn()
    }
}
