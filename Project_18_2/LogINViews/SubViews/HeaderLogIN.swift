//
//  HeaderLogIN.swift
//  Project 18
//
//  Created by Никита Фролов  on 30.03.2021.
//

import SwiftUI

struct HeaderLogIN: View {
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var navigationLeftButton: Bool
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                ConstantsColors.background
                    .ignoresSafeArea(.all)
                VStack {
                    if navigationLeftButton {
                        ZStack {
                            HStack {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    HStack {
                                        Image(systemName: "chevron.backward")
                                            .foregroundColor(.white)
                                            .imageScale(.large)
                                        Text("LOGIN")
                                            .font(.custom("Roboto-Bold", size: 20))
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                })
                                Spacer()
                            }
                            Text(title)
                                .font(.custom("Roboto-Bold", size: 25))
                                .foregroundColor(.white)
                        }
                    } else {
                        HStack {
                            Text(title)
                                .font(.custom("Roboto-Bold", size: 25))
                                .foregroundColor(.white)
                                .padding()
                            Spacer()
                        }
                    }
                    Spacer()
                    Image("PlusCircleGray")
                }
            }
        }
    }
}

struct HeaderLogIN_Previews: PreviewProvider {
    static var previews: some View {
        HeaderLogIN(title: "PROJECT 18", navigationLeftButton: false)
    }
}
