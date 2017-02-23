//
//  productPics.swift
//  Hatchling
//
//  Created by Steven Graf on 1/19/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class productPics: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , hasDataDict{
    var dataDict: Dictionary<String, AnyObject> = [:]
    var imagePicked:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productImagePicker.delegate = self

        
        
        let pictureTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pickProductPictureTapped(_:)))
        productPicture.isUserInteractionEnabled = true
        productPicture.addGestureRecognizer(pictureTap)

        let logoTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pickLogoPictureTapped(_:)))
        logoPicture.isUserInteractionEnabled = true
        logoPicture.addGestureRecognizer(logoTap)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var productPicture: UIImageView!
    @IBOutlet weak var logoPicture: UIImageView!

    let productImagePicker = UIImagePickerController()

    @IBAction func pickLogoPictureTapped(_ sender: Any) {
        print("picking Logo Picture")
        imagePicked = logoPicture
        productImagePicker.allowsEditing = true
        
        present(productImagePicker, animated: true, completion: nil)
        
    }

    @IBAction func pickProductPictureTapped(_ sender: Any) {
        print("picking Product Picture")
         imagePicked = productPicture
        productImagePicker.allowsEditing = true
        
        present(productImagePicker, animated: true, completion: nil)
    }

    @IBAction func nextBtnTapped(_ sender: Any) {
        
        //NEED TO PUT SOMETHIGN IN TO MAKE SURE THEY PICKED SOMETHIGN OR HAVE A DEFAULT IMAGe
        let productImg = productPicture.image
        let logoImg = logoPicture.image
        dataDict[postDataTypes.productImg] = productImg as AnyObject
        dataDict[postDataTypes.logoImg] = logoImg as AnyObject
        performSegue(withIdentifier: "toProductConnectionsSegue", sender: self)
    }
    
    //MARK: - Delegates
      func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imagePicked.contentMode = .scaleAspectFit //3
       imagePicked.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        switch(dest){
        case is hasDataDict:
            var destVC = dest as! hasDataDict
            destVC.dataDict = self.dataDict
        default:
            print("Default in switch statment")
        }
    }
    
}
