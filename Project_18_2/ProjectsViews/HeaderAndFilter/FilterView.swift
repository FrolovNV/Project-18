//
//  FilterView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import SwiftUI

struct FilterView: View {
    @Binding var selected: Int
    
    let titles = ["By title", "By favorite and title", "By creation date", "By complition date"]
    
    var body: some View {
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
                                .foregroundColor((selected == num) ? .green : .white)
                                .padding()
                            VStack(alignment: .leading) {
                                Button(action: {
                                    self.selected = num
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
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(selected: .constant(1))
    }
}
