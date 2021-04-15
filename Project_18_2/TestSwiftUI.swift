//
//  TestSwiftUI.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 15.04.2021.
//

import SwiftUI

struct TestSwiftUI: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Sign Out")
                .font(.custom("Roboto-Bold", size: 25))
                .foregroundColor(Color("RedError"))
        })
    }
}

struct TestSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        TestSwiftUI()
    }
}
