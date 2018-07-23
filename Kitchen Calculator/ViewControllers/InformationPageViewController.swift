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
    
    
    var caloriesAmount:Double = 0.0
    var fatAmount:Double = 0.0
    var satFatAmount:Double = 0.0
    var SodiumAmount:Double = 0.0
    var sugarAmount:Double = 0.0
    var carbsAmount:Double = 0.0
    var proteinAmount:Double = 0.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    
    var barcode:String? {
        didSet{
            guard let barcode = barcode  else {
                print("Error getting bardcode from previous view controllor")
                return
            }
            DispatchQueue.global(qos: .userInitiated).async{
                NutritionAPI.getFoodItem(barcode: barcode) { (foodItem, error) in
                    self.foodItem = foodItem
                }
                
            }
        }
    }
    
    //perform UI changes
    var foodItem: Food? {
        didSet {
            
            request((foodItem?.imageURL)!, method: .get).responseImage { response in
                
                guard response.result.value != nil else {
                    self.foodImage.image = UIImage(named: "Error")!
                    self.titleLabel.text = "No product Information found."
                    self.continueButton.isHidden = true
                    print("No product found.")
                    return
                }
                
                
                self.foodImage.image = response.result.value
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
        
        performSegue(withIdentifier: "toScale", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("segue was called")
        let destination = segue.destination as? SaveHealthDataViewController
        
        destination?.weight = self.getDigits(digitizedString: (self.foodItem?.weight)!)
        destination?.calories = self.caloriesAmount
        destination?.fat = self.fatAmount
        destination?.satFat = self.satFatAmount
        destination?.sodium = self.SodiumAmount
        destination?.sugar = sugarAmount
        destination?.carbs = carbsAmount
        destination?.protein = proteinAmount
        
        
    }
    
    
    
    
    
    //TODO: Fix to get only number from string not remove last digit
    func getDigits(digitizedString : String) -> Double{
        let digitizedString = digitizedString.components(separatedBy: CharacterSet.decimalDigits).joined()
        print("digitized String: \(digitizedString)")
        
        guard let returnedDigit = Double(digitizedString) else {
            print("The digitized string is nil, guard statement failed.")
            return 0.0
        }
        return returnedDigit
        
    }
    
    func populateUI() {
        
        self.titleLabel.text = (self.foodItem?.title)!
        self.titleLabel.numberOfLines = 0
        
        
        //CALORIES
        if self.foodItem?.properties["energy"] == JSON.null {
            self.caloriesLabel.attributedText = self.caloriesLabel.attributedText?.attributedText(withString: " Total Calories: 0.0", boldString: " Total Calories: ", font: UIFont.systemFont(ofSize: 17))
            self.caloriesAmount = 0.0
        } else {
            
            self.caloriesAmount = round(100 * (self.getDigits(digitizedString: (self.foodItem?.weight)!) / self.self.getDigits(digitizedString: (self.foodItem?.properties["energy"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["energy"]["amount"].stringValue)!)! ) / 100
            
            self.caloriesLabel.attributedText = self.caloriesLabel.attributedText?.attributedText(withString: " Total Calories: " + String(describing: self.caloriesAmount) + " calories.", boldString: " Total Calories: ", font: UIFont.systemFont(ofSize: 17))
        }
        
        
        //FAT
        if self.foodItem?.properties["fat"] == JSON.null {
            self.fatLabel.attributedText = self.fatLabel.attributedText?.attributedText(withString: " Total Fat: 0.0g", boldString: " Total Fat: ", font: UIFont.systemFont(ofSize: 17))
            self.fatAmount = 0.0
        } else {
            
            self.fatAmount = round(100 * (self.getDigits(digitizedString: (self.foodItem?.weight)!) / self.getDigits(digitizedString: (self.foodItem?.properties["fat"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["fat"]["amount"].stringValue)!)! ) / 100
            
            self.fatLabel.attributedText = self.fatLabel.attributedText?.attributedText(withString: " Total Fat: " + String(describing: self.fatAmount) + " grams.", boldString: " Total Fat: ", font: UIFont.systemFont(ofSize: 17))
        }
        //SATURATED FAT
        if self.foodItem?.properties["satfat"] == JSON.null {
            self.satFatLabel.attributedText = self.satFatLabel.attributedText?.attributedText(withString: " Total Saturated Fat: 0.0g", boldString: " Total Saturated Fat: ", font: UIFont.systemFont(ofSize: 17))
            self.satFatAmount = 0.0
        } else {
            self.satFatAmount = round(100 * (self.getDigits(digitizedString: (self.foodItem?.weight)!) / self.getDigits(digitizedString: (self.foodItem?.properties["satfat"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["satfat"]["amount"].stringValue)!)! ) / 100
            
            self.satFatLabel.attributedText = self.satFatLabel.attributedText?.attributedText(withString: " Total Saturated Fat: " + String(describing: self.satFatAmount) + " grams.", boldString: " Total Saturated Fat: ", font: UIFont.systemFont(ofSize: 17))
        }
        
        //SODIUM
        if self.foodItem?.properties["sodium"] == JSON.null {
            
            self.sodiumLabel.attributedText = self.sodiumLabel.attributedText?.attributedText(withString: " Total Sodium: 0.0g", boldString: " Total Sodium: ", font: UIFont.systemFont(ofSize: 17))
            self.SodiumAmount = 0.0
        } else {
            self.SodiumAmount = round(100 * (self.getDigits(digitizedString: (self.foodItem?.weight)!) / self.getDigits(digitizedString: (self.foodItem?.properties["sodium"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["sodium"]["amount"].stringValue)!)! ) / 100
            
            self.sodiumLabel.attributedText = self.sodiumLabel.attributedText?.attributedText(withString: " Total Sodium: " + String(describing: self.SodiumAmount) + " grams.", boldString: " Total Sodium: ", font: UIFont.systemFont(ofSize: 17))
        }
        
        //SUGAR
        if self.foodItem?.properties["sugar"] == JSON.null {
            self.sugarLabel.attributedText = self.sugarLabel.attributedText?.attributedText(withString: " Total Sugar: 0.0g", boldString: " Total Sugar: ", font: UIFont.systemFont(ofSize: 17))
            self.sugarAmount = 0.0
        } else {
            self.sugarAmount = round(100 * (self.getDigits(digitizedString: (self.foodItem?.weight)!) / self.getDigits(digitizedString: (self.foodItem?.properties["sugar"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["sugar"]["amount"].stringValue)!)! ) / 100
            
            self.sugarLabel.attributedText = self.sugarLabel.attributedText?.attributedText(withString: " Total Sugar: " + String(describing: self.sugarAmount) + " grams.", boldString: " Total Sugar: ", font: UIFont.systemFont(ofSize: 17))
        }
        
        //CARBS
        if self.foodItem?.properties["carbs"] == JSON.null {
            self.carbsLabel.attributedText = self.carbsLabel.attributedText?.attributedText(withString: " Total Carbs: 0.0g", boldString: " Total Carbs: ", font: UIFont.systemFont(ofSize: 17))
            self.carbsAmount = 0.0
        } else {
            self.carbsAmount = round(100 * (self.getDigits(digitizedString: (self.foodItem?.weight)!) / self.getDigits(digitizedString: (self.foodItem?.properties["carbs"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["carbs"]["amount"].stringValue)!)! ) / 100
            
            self.carbsLabel.attributedText = self.carbsLabel.attributedText?.attributedText(withString: " Total Carbs: " + String(describing: self.carbsAmount) + " grams.", boldString: " Total Carbs: ", font: UIFont.systemFont(ofSize: 17))
        }
        
        //PROTEIN
        if self.foodItem?.properties["protein"] == JSON.null   {
            
            self.proteinLabel.attributedText = self.proteinLabel.attributedText?.attributedText(withString: " Total Protein: 0.0g", boldString: " Total Protein: ", font: UIFont.systemFont(ofSize: 17))
            self.proteinAmount = 0.0
        } else {
            self.proteinAmount = round(100 * (self.getDigits(digitizedString: (self.foodItem?.weight)!) / self.getDigits(digitizedString: (self.foodItem?.properties["protein"]["per"].stringValue)!)) * (Double)((self.foodItem?.properties["protein"]["amount"].stringValue)!)! ) / 100
            
            self.proteinLabel.attributedText = self.carbsLabel.attributedText?.attributedText(withString: " Total Protein: " + String(describing: self.proteinAmount) + " grams.", boldString: " Total Protein: ", font: UIFont.systemFont(ofSize: 17))
        }
    }
    
    
    
    
}

extension NSAttributedString {
    
    public func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedStringKey.font: font])
        let boldFontAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    
    
}


