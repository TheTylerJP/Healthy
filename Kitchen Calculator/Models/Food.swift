//
//  Food.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/6/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire



public enum foodError: Error {
    case invalidJSON
}



struct Food{
    let productId:String
    let title:String
    let description:String
    let imageURL:String
    let price:String
    
    let nutrients: Nutrients
    let healthnotes:String
    let weight:String
    
    init?(json:JSON) {
        self.productId = json["productId"].stringValue
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        self.imageURL = json["image"].stringValue
        self.price = json["price"].stringValue
        self.nutrients = Nutrients(withData: json["properties"])
        self.healthnotes = json["healthnotes"].stringValue
        self.weight = json["weight"].stringValue
    }
    
    
    


        
    
    
}
