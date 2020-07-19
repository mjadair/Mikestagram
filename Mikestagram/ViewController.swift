//
//  ViewController.swift
//  Mikestagram
//
//  Created by Michael Adair on 18/07/2020.
//  Copyright © 2020 Michael Adair. All rights reserved.
//

import UIKit


// The controller for the page - with image and navigation controller delegates
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // context allows for image processing within the controller
    let context = CIContext()
    
    // the original image selected by the user
    var original: UIImage!
    
    
    // the image view in our storyboard
    @IBOutlet var imageView: UIImageView!
 
    
    // allows the user to select a photo from their iOS library
    @IBAction func choosePhoto() {
        
        // if the user photo library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // use the controller
            let picker = UIImagePickerController()
            // assign values to keys
            picker.delegate = self
            picker.sourceType = .photoLibrary
            
            // assign the controller to present the image selected, with the additional keys added above
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    
    // this is our display helper function, it takes a filter as an argument and applies it to the selected image in the Image view.
      func display(filter: CIFilter) {
          
          guard let original = original else {
              return
          }
          filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
          let output = filter.outputImage
          imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
          
      }
    
    
    // sepia filter function
    @IBAction func applySepia() {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        
         print(filter)
   
        display(filter: filter!)

    }
    
    
    
    
    // noir filter function
    @IBAction func applyNoir(){
        if original == nil {
                  return
              }
        
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
        
    }
    
    
    // vintage filter function
    @IBAction func applyVintage(){
        
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
    
        display(filter: filter!)
    }
    
    
    
    // vintage filter function
    @IBAction func applyPixellate(){
        
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPixellate")
        
        print(filter)
    
        display(filter: filter!)
    }
    
    

    
    
    // This function displays the image selected from the photo library in our main view.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            imageView.image = image
            original = image
        }
    }
  

}

