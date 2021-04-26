//
//  Project_18_2App.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 06.04.2021.
//

import SwiftUI

@main
struct Project_18_2App: App {
    let context = PersistenceController.persistentContainer.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
        }
    }
}
