//
//  BaseImagePickerVC.swift
//  TailerOnline
//
//  Created by apple on 4/4/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//
import UIKit


protocol BaseImagePickerVCDelegate: class {
    func mySelectedImage(image: UIImage)
}


class BaseImagePickerVC: BaseVC {
    
    var imagePickerDelegate: BaseImagePickerVCDelegate?
    
//    var title : String?
//    var message = "Please Select an Option"
    var camera = "Camera"
    var photo = "Photo Library"
    var cancel = "Cancel"
    var selectedImage : UIImage?
    
    
    
    
//    func pickImageBtnTapped(sender: UIButton) {
//
////        self.alertPickerOptions()
//    }
    func showImagePicker(){
        selectSource()
    }
    func uploadImage(image : UIImage){
        
    }
    private func selectSource(){
        
    
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: photo, style: .default , handler:{ [weak self] (UIAlertAction)in
            self?.imagePicker(isCamera: false)
        }))
        
        
        alert.addAction(UIAlertAction(title: camera , style: .default , handler:{ [weak self] (UIAlertAction)in
            
             self?.imagePicker(isCamera: true)
        }))
        
        alert.addAction(UIAlertAction(title: cancel , style: .cancel , handler:{ (UIAlertAction)in
            
             print("Cancel")
            
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    private func imagePicker(isCamera : Bool){
        let vc = UIImagePickerController()
        vc.sourceType = isCamera ? .camera : .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    
}


extension BaseImagePickerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        selectedImage = image
         imagePickerDelegate?.mySelectedImage(image: image)
        uploadImage(image: image)
        // print out the image size as a test
        print(image.size)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
   
}

