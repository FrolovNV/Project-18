//
//  TaskHeaderView.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 29.04.2021.
//

import SwiftUI

struct TaskHeaderView: View {
    
    @ObservedObject var viewModel: TaskHeaderViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Text(viewModel.title)
                        .font(.custom("Roboto-Bold", size: 20))
                        .foregroundColor(.black)
                }
            })
            Spacer()
            Button(action: {
//                viewModel.showSheetOfFilter.toggle()
//                viewModel.dragOffset = 0
//                viewModel.opacityBackground = 0.5
            }, label: {
                Image("Filtter")
                    
            })
            .foregroundColor(.black)
        }
        .padding()
        .frame(height: 70)
    }
}

struct TaskHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TaskHeaderView(viewModel: TaskHeaderViewModel())
    }
}
