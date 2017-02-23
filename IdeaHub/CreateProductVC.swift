//
//  CreateProductVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 2/17/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class CreateProductVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedCreateNewBtn(_ sender: Any) {
        presentCreatProductDetailsVC(sender:self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
