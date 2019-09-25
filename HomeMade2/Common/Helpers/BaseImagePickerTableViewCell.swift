//
//  BaseImagePickerTableViewCell.swift
//  TailerOnline
//
//  Created by iOSDev on 4/18/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit


protocol BaseImagePickerTableViewCellDelegate: class {
    func mySelectedImage(image: UIImage)
}


class BaseImagePickerTableViewCell: BaseLocationTableViewCell {
    
    var imagePickerDelegate: BaseImagePickerTableViewCellDelegate?
    
    struct alertPicker {
        static var title = "Title"
        static var message = "Please Select an Option"
        static var camera = "Camera"
        static var photo = "Photo Library"
        static var cancel = "Cancel"
    }
    
    
    
    @IBAction func pickImageBtnTapped(sender: UIButton) {
        
        self.alertPickerOptions()
    }
    
    
    private func alertPickerOptions() {
        
        let alert = UIAlertController(title: alertPicker.message, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: alertPicker.photo, style: .default , handler:{ (UIAlertAction)in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.allowsEditing = true
            vc.delegate = self
            self.sharedVC?.present(vc, animated: true)
        }))
        
        
        alert.addAction(UIAlertAction(title: alertPicker.camera , style: .default , handler:{ (UIAlertAction)in
            
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            self.sharedVC?.present(vc, animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: alertPicker.cancel , style: .cancel , handler:{ (UIAlertAction)in
            
            print("Cancel")
            
        }))
        
        sharedVC?.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
}


extension BaseImagePickerTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        imagePickerDelegate?.mySelectedImage(image: image)
        // print out the image size as a test
        print(image.size)
    }
    
    
}


class BaseProfileTableViewCell: BaseImagePickerTableViewCell {
    
}

