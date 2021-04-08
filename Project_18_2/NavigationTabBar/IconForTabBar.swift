//
//  IconForTabBar.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 08.04.2021.
//

import SwiftUI

struct IconForTabBar: View {
    
    @State var imageName: String
    @State var name: String
    var flag: Bool
    
    var body: some View {
        if flag {
            HStack(spacing: 1) {
                Image(systemName: imageName)
                    .foregroundColor(.white)
                Text(name)
                    .font(.custom("Roboto-Medium", size: 10))
                    .foregroundColor(.white)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 58, height: 30)
                    .foregroundColor(Color.init("Blue"))
            )
        } else {
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.white)
            }
            .frame(width: 58, height: 30)
        }
    }
}

struct IconForTabBar_Previews: PreviewProvider {
    static var previews: some View {
        IconForTabBar(imageName: "bag", name: "Project", flag: false)
    }
}
