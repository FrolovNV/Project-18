//
//  ContentView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 06.04.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var animationStart = false
    @State private var endSplash = false
    
    var body: some View {
        if endSplash {
            NavigationLogIn()
                .environment(\.managedObjectContext, viewContext)
        } else {
            ZStack {
                ConstantsColors.background
                Image("Label")
                    .offset(y: -200)
                Image("PlusCircle")
                    .resizable()
                    .aspectRatio(contentMode: animationStart ? .fill : .fit)
                    .frame(width: animationStart ? nil : 200, height: animationStart ? nil : 200)
                    .scaleEffect(animationStart ? 3 : 1)
                
            }
            .ignoresSafeArea()
            .onAppear {
                animatingSplash()
            }
            .opacity(endSplash ? 0 : 1)
        }
    }
    
    func animatingSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(Animation.easeOut(duration: 0.75)) {
                self.animationStart.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.75)) {
                self.endSplash.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.persistentContainer.viewContext)
    }
}
