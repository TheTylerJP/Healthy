//
//  Nutrients.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 7/24/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Nutrients {
    
    var caloriesAmount:Double
    var fatAmount:Double
    var satFatAmount:Double
    var sodiumAmount:Double
    var sugarAmount:Double
    var carbsAmount:Double
    var proteinAmount:Double
    
    init(withData json:JSON){
        
        if json["energy"] == JSON.null {
            caloriesAmount = 0
        } else {
            caloriesAmount = JSON.returnDigits(fromJSON: json["energy"]["amount"])
        }
        
        if json["fat"] == JSON.null {
            fatAmount = 0
        } else {
            fatAmount = JSON.returnDigits(fromJSON: json["fat"]["amount"])
            
        }
        
        if json["satfat"] == JSON.null {
            satFatAmount = 0
        } else {
            satFatAmount = JSON.returnDigits(fromJSON: json["satfat"]["amount"])
        }
        
        if json["sodium"] == JSON.null {
            sodiumAmount = 0
        } else {
            sodiumAmount = JSON.returnDigits(fromJSON: json["sodium"]["amount"])

        }
        
        if json["sugar"] == JSON.null {
            sugarAmount = 0
        } else {
            sugarAmount = JSON.returnDigits(fromJSON: json["sugar"]["amount"])
            
        }
        
        if json["carbs"] == JSON.null {
            carbsAmount = 0
        } else {
            carbsAmount = JSON.returnDigits(fromJSON: json["carbs"]["amount"])
            
        }
        
        if json["protein"] == JSON.null {
            proteinAmount = 0
        } else {
            proteinAmount = JSON.returnDigits(fromJSON: json["protein"]["amount"])
        }
        
    }
   
    mutating func addNutrients(withServingsMultiplier servings: Int) {
       caloriesAmount       *= Double(servings)
       fatAmount            *= Double(servings)
       satFatAmount         *= Double(servings)
       sodiumAmount         *= Double(servings)
       sugarAmount          *= Double(servings)
       carbsAmount          *= Double(servings)
       proteinAmount        *= Double(servings)

    }
}

/*=============================================================================*/
extension JSON {
    //TODO: Fix to get only number from string not remove last digit
    static func returnDigits(fromJSON json: JSON) -> Double{
        let digitizedString = json.stringValue.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted)
        guard let returnedDigit = Double(digitizedString) else {
            return 0.0
        }
        return returnedDigit
        
    }
}
