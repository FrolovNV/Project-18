//
//  FilterView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var headerViewModel: ProjectHeaderViewModel
    
    let titles = ["By title", "By favorite and title", "By creation date", "By complition date"]
    
    var body: some View {
        if headerViewModel.showSheetOfFilter {
            VStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width, height: 350)
                    .overlay(
                        VStack() {
                            HStack {
                                Text("FILTER")
                                    .font(.custom("Roboto-Bold", size: 20))
                                Spacer()
                            }.padding()
                            ForEach(0..<titles.count) { num in
                                HStack {
                                    Spacer()
                                    Image("Done")
                                        .foregroundColor((headerViewModel.selectedFilterMode == num) ? .green : .white)
                                        .padding()
                                    VStack(alignment: .leading) {
                                        Button(action: {
                                            self.headerViewModel.selectedFilterMode = num
                                            withAnimation {
                                                self.headerViewModel.showSheetOfFilter.toggle()
                                            }
                                        }, label: {
                                            Text(titles[num])
                                                .font(.custom("Roboto-Bold", size: 20))
                                        })
                                        .foregroundColor(.black)
                                        Divider()
                                    }
                                    Spacer()
                                }
                            }
                        }
                )
                Spacer()
            }
            .offset(y: headerViewModel.dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { event in
                        let newOffset = event.translation.height
                        if newOffset < 0 {
                            self.headerViewModel.dragOffset = newOffset
                        }
                    }
                    .onEnded {_ in
                        withAnimation{
                            self.headerViewModel.showSheetOfFilter.toggle()
                        }
                    }
            )
            .transition(.move(edge: .top))
            .animation(.default)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(headerViewModel: ProjectHeaderViewModel())
    }
}
