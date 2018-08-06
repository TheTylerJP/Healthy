
import HealthKit

class HealthKitSetupAssistant {
  
    public let healthStore = HKHealthStore()
    
    public var nutritionalData : Set<HKSampleType> = [
        HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!,
        HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated)!,
        HKObjectType.quantityType(forIdentifier: .dietarySodium)!,
        HKObjectType.quantityType(forIdentifier: .dietarySugar)!,
        HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
        HKObjectType.quantityType(forIdentifier: .dietaryProtein)!
    ]
    //var test : Set<HKSampleType> = []
    
    public func requestPermission() {
        
        healthStore.requestAuthorization(toShare: nutritionalData, read: nil, completion: { (success, error) in
            if success {
            print("Authorization complete.")
            } else {
            print("Authorization failed.")
            }
        })
    }
    

    
}
