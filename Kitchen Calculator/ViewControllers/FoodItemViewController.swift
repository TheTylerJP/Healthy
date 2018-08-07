	//
//  FoodItemViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 8/5/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class FoodItemViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    var food: Food? {
        didSet {
            print(food?.title)

        }
    }




    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = food?.title ?? "no food item"
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
