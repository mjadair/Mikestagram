//
//  ViewController.swift
//  Mikestagram
//
//  Created by Michael Adair on 18/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let context = CIContext()
    var original: UIImage!
    
    @IBOutlet var imageView: UIImageView!
 
    

    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func applySepia() {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
   
        display(filter: filter!)

    }
    
    
    @IBAction func applyNoir(){
        if original == nil {
                  return
              }
        
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
        
    }
    
    
    @IBAction func applyVintage(){
        
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
    
        display(filter: filter!)
    }
    
    
    func display(filter: CIFilter) {
        
        guard let original = original else {
            return
        }
        filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            imageView.image = image
            original = image
        }
    }
  

}

