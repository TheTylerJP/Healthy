//
//  FoodItemViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 8/5/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class FoodItemViewController: UIViewController {

    var food: Food? {
        didSet {
            print(food?.title)
            testLabel.text = food?.title
        }
    }
    @IBOutlet weak var testLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
