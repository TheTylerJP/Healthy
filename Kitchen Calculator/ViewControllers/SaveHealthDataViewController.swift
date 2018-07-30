//
//  SaveHealthDataViewController.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/25/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit
import HealthKit



class SaveHealthDataViewController: UIViewController{
    

    public let healthStore = HKHealthStore()
    
    @IBOutlet weak var saveButton: UIButton!
    
    var foodItem = [Food]()
    
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        if HKHealthStore.isHealthDataAvailable() {
            print("Yes, HealthKit is Available")
            let healthManager = HealthKitSetupAssistant()
            healthManager.requestPermission()
        } else {
            print("There is a problem accessing HealthKit")
        }
        
        
    }
    
    
    
    
    


    /*
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
    }*/
    
    
    
    


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
    
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
