//
//  HeaderProjectView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 20.04.2021.
//

import SwiftUI



struct HeaderProjectView: View {
    @ObservedObject var viewModel: ProjectHeaderViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
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

struct HeaderProjectView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderProjectView(viewModel: ProjectHeaderViewModel())
    }
}
