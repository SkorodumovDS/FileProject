//
//  ImagePicker.swift
//  FileProject
//
//  Created by Skorodumov Dmitry on 01.10.2023.
//

import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate,  UINavigationControllerDelegate{
    
    var imagePickerController: UIImagePickerController?
    var competion : ((UIImage)-> ())?
    let pathToDocum = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                      .userDomainMask, true)[0])
    func showImagePicker(in viewController: UIViewController, completion: ((UIImage)-> ())?) {
        self.competion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image  = info[.originalImage] as? UIImage {
            self.competion?(image)
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

