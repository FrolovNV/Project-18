//
//  ImagePicker.swift
//  Project_18_2
//
//  Created by Никита Фролов  on 15.04.2021.
//

import UIKit
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShowSheet: Bool
    @Binding var image: UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = UIImagePickerController()
        view.delegate = context.coordinator
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.parent.image = selectedImage
            }
            self.parent.isShowSheet.toggle()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
}
