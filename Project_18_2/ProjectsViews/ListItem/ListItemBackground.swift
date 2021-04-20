//
//  ListItemBackground.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI

class HeaderViewModel: ObservableObject{
    @Published public var title = "PROJECT"
    @Published public var flag = false
    @Published public var showSheetOfFilter = false
    @Published public var selectedFilterMode = 0
    @Published public var dragOffset: CGFloat = -400
    @Published public var opacityBackground = 0.0
}




struct ListItemBackground: View {
    @EnvironmentObject var userSettings: UserDefaultsSettings
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var  headerViewModel = HeaderViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderProjectView(viewModel: headerViewModel)
                    .offset(y: 10)
                    .frame(height: 100)
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0..<10) { _ in
                            ListItem()
                                .padding()
                        }
                    }
                }
            }
            
            Color.black.opacity(headerViewModel.opacityBackground)
                .transition(.opacity)
            VStack {
                FilterView(selected: $headerViewModel.selectedFilterMode)
                    .offset(y: headerViewModel.dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged({event in
                                let newHeight = event.translation.height
                                if newHeight < 0 {
                                    self.headerViewModel.dragOffset = event.translation.height
                                }
                                
                            })
                            .onEnded({ event in
                                let newHeight = event.translation.height
                                if newHeight < -120 {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.headerViewModel.opacityBackground = 0
                                        self.headerViewModel.dragOffset = -400
                                    }
                                    self.headerViewModel.showSheetOfFilter = false
                                } else {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.headerViewModel.dragOffset = 0
                                    }
                                }
                            })
                    )
                Spacer()
            }
        }
        .background(Color.gray.opacity(0.15))
        .ignoresSafeArea(.all)
    }
}

struct ListItemBackground_Previews: PreviewProvider {
    static var previews: some View {
        ListItemBackground()
    }
}
