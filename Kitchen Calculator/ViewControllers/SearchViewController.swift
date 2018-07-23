//
//  SearchViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 7/23/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController {

    var foodList: ItemList? {
        didSet {
            print(foodList?.items.count)
        }
    }
    
    
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        if let keywordQuery = searchField.text {
            DispatchQueue.global(qos: .userInitiated).async {
                NutritionAPI.searchItems(itemToSearch: keywordQuery, completion: { (itemList, error) in
                    self.foodList = itemList
                    print("search button click complete")
                    
                })
            }
        }
        
    }
    @IBOutlet weak var textBox: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
