//
//  HeaderSettings.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 11.04.2021.
//

import SwiftUI

struct HeaderSettings: View {
    
    var imageName: UIImage?
    var firstName: String
    var lastName: String
    var email: String
    var mobileNumber: String
    
    var body: some View {
        ZStack {
            ZStack {
                ConstantsColors.background
                    .ignoresSafeArea(.all)
                HStack {
                    Image(uiImage: imageName ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .padding()
                    VStack(alignment: .leading) {
                        Text(firstName + " " + lastName)
                            .font(.custom("Roboto-Bold", size: 23))
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        Text(email)
                            .font(.custom("Roboto-Medium", size: 15))
                            .foregroundColor(.white)
                        Text(mobileNumber)
                            .font(.custom("Roboto-Medium", size: 15))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
        }
    }
}

//struct HeaderSettings_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderSettings(imageName: "Me", firstName: "Nikita", lastName: "Frolov", email: "frolovNikita", mobileNumber: "666-666-666")
//    }
//}
