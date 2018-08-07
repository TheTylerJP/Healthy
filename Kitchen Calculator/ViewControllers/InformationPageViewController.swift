//
//  InformationPageViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/7/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

import SwiftyJSON
import AlamofireImage
import Alamofire


class InformationPageViewController: UIViewController {
    
    var counter:Int = 0

    var barcode:String? {
        didSet{
            guard let barcode = barcode  else {
                print("Error getting bardcode from previous view controllor")
                return
            }
            DispatchQueue.global(qos: .userInitiated).async{
                NutritionAPI.getFoodItem(withBarcode: barcode) { (foodItem, error) in
                    if let food = foodItem {
                            self.foodItem = food
                        }
                    }
                }
                
            }
        }
    
    //perform UI changes
    var foodItem: Food? {
        didSet {
            DispatchQueue.main.async {
                self.populateUI()
            }  
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Product Information"
        
        

        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func continueButton(_ sender: Any) {
        
        // performSegue(withIdentifier: "toScale", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("segue was called")
        //let destination = segue.destination as? SaveHealthDataViewController
        
    }
    
    
    
    
    
    
    
    func populateUI() {

    }
    
    
    
    
}

extension String {
    
    public func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    
    
}


