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
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var satFatLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    
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
        
        
        
        continueButton.layer.borderColor = UIColor.black.cgColor
        continueButton.layer.borderWidth = 2.0
        continueButton.layer.cornerRadius = 4.0
        
        
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
        
        self.titleLabel.text = foodItem?.title
        self.titleLabel.numberOfLines = 0
        
        if let food = foodItem {
            caloriesLabel.text = String(food.nutrients.caloriesAmount)
            fatLabel.text = String(food.nutrients.fatAmount)
            satFatLabel.text = String(food.nutrients.satFatAmount)
            sodiumLabel.text = String(food.nutrients.SodiumAmount)
            sugarLabel.text = String(food.nutrients.SodiumAmount)
            carbsLabel.text = String(food.nutrients.SodiumAmount)
            proteinLabel.text = String(food.nutrients.SodiumAmount)
            foodImage.image = foodItem?.image
            
        }
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


