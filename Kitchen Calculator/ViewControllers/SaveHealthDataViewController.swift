//
//  SaveHealthDataViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/25/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit
import HealthKit

protocol nutritionalInformation {
    var servings : Int {get set}
    var calories : Double {get set}
    var fat : Double {get set}
    var satFat : Double {get set}
    var sodium : Double {get set}
    var sugar : Double {get set}
    var carbs : Double {get set}
    var protein : Double {get set}
}

class SaveHealthDataViewController: UIViewController, nutritionalInformation {
    

    public let healthStore = HKHealthStore()
    
    @IBOutlet weak var saveButton: UIButton!
    var percentMultiplier:Double? {
        didSet {
            if let multiplier = percentMultiplier {
                calories *= multiplier
                fat *= multiplier
                satFat *= multiplier
                sodium *= multiplier
                sugar *= multiplier
                carbs *= multiplier
                protein *= multiplier
            }
        }
    }
    var weight:Double = 0.0
    var calories:Double = 0.0
    var fat:Double = 0.0
    var satFat:Double = 0.0
    var sodium:Double = 0.0
    var sugar:Double = 0.0
    var carbs:Double = 0.0
    var protein:Double = 0.0
    var servings: Int = 0
    
    //TODO: Remove weight
    var iPhoneWeight:Double? {
        didSet {
            if let iPhoneWeight = iPhoneWeight {
                percentMultiplier = iPhoneWeight / weight
                print("Weight: " + String(weight))
                print("IPhone Weight: " + String(iPhoneWeight))
                print(percentMultiplier ?? "Percent multiplier: 1")
            } else {
                percentMultiplier = 1.0
            }
        }
    }
    
    
    //Labels
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var satFatLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleButtons()
        styleLabels()
        
        if HKHealthStore.isHealthDataAvailable() {
            print("Yes, HealthKit is Available")
            let healthManager = HealthKitSetupAssistant()
            healthManager.requestPermission()
        } else {
            print("There is a problem accessing HealthKit")
        }
        
        
    }
    
    
    
    
    
    
    @IBAction func saveToHealthKit(_ sender: Any) {
        writeToKit()
    }
    

    func writeToKit() {
        let date = Date()
        let caloriesSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryEnergyConsumed)!, quantity: HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: self.calories), start: date, end: date)
        
        let fatSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryFatTotal)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.fat), start: date, end: date)
        
        let satFatSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryFatSaturated)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.satFat), start: date, end: date)
        
        let sodiumSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietarySodium)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.sodium), start: date, end: date)
        
        let sugarSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietarySugar)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.sugar), start: date, end: date)
        
        let carbsSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryCarbohydrates)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.carbs), start: date, end: date)
        
        let proteinSample = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: .dietaryProtein)!, quantity: HKQuantity(unit: HKUnit.gram(), doubleValue: self.protein), start: date, end: date)
        
        let nutritionalData = [caloriesSample, fatSample, satFatSample, sodiumSample, sugarSample, carbsSample, proteinSample]
        
        
        healthStore.save(nutritionalData) { (success, error) in
            if let error = error {
                print(error)
            } else {
                print("success: \(success)")
            }
        }
    }
    
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func styleButtons() {
        navigationItem.title = "Updated Information"
        saveButton.layer.borderColor = UIColor.black.cgColor
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.cornerRadius = 4.0
    }
    
    func styleLabels() {
        caloriesLabel.attributedText = caloriesLabel.attributedText?.attributedText(withString: " Total Calories: " + String(describing: self.calories) + " calories.", boldString: " Total Calories: ", font: UIFont.systemFont(ofSize: 17))
        
        fatLabel.attributedText = fatLabel.attributedText?.attributedText(withString: " Total Fat: " + String(describing: self.fat) + " grams.", boldString: " Total Fat: ", font: UIFont.systemFont(ofSize: 17))
        
        satFatLabel.attributedText = satFatLabel.attributedText?.attributedText(withString: " Total Saturated Fat: " + String(describing: self.satFat) + " grams.", boldString: " Total Saturated Fat: ", font: UIFont.systemFont(ofSize: 17))
        
        sodiumLabel.attributedText = sodiumLabel.attributedText?.attributedText(withString: " Total Sodium: " + String(describing: self.sodium), boldString: " Total Sodium: ", font: UIFont.systemFont(ofSize: 17))
        
        sugarLabel.attributedText = sugarLabel.attributedText?.attributedText(withString: " Total Sugar: " + String(describing: self.sugar) + " grams.", boldString: " Total Sugar: ", font: UIFont.systemFont(ofSize: 17))
        
        carbsLabel.attributedText = carbsLabel.attributedText?.attributedText(withString: " Total Carbs: " + String(describing: self.carbs) + " grams.", boldString: " Total Carbs: ", font: UIFont.systemFont(ofSize: 17))
        
        proteinLabel.attributedText = proteinLabel.attributedText?.attributedText(withString: " Total Protein: " + String(describing: self.protein) + " grams.", boldString: " Total Protein: ", font: UIFont.systemFont(ofSize: 17))
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
