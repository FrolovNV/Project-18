//
//  HeaderProjectView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import SwiftUI



struct HeaderProjectView: View {
    @ObservedObject var viewModel: HeaderViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            if viewModel.flag {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.black)
                                .imageScale(.large)
                            Text("LOGIN")
                                .font(.custom("Roboto-Bold", size: 20))
                                .foregroundColor(.black)
                        }
                        .padding()
                    })
                    Spacer()
                    Button(action: {
                        viewModel.showSheetOfFilter.toggle()
                        viewModel.dragOffset = 0
                        viewModel.opacityBackground = 0.5
                    }, label: {
                        Image("Filtter")
                            .padding()
                    })
                    .foregroundColor(.black)
                    
                }
            } else {
                HStack {
                    Text(viewModel.title)
                        .font(.custom("Roboto-Bold", size: 20))
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                    Button(action: {
                        viewModel.showSheetOfFilter.toggle()
                        viewModel.dragOffset = 0
                        viewModel.opacityBackground = 0.5
                    }, label: {
                        Image("Filtter")
                            .padding()
                    })
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct HeaderProjectView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderProjectView(viewModel: HeaderViewModel())
    }
}
