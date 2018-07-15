//
//  Item.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 7/3/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

public class ItemList {
    
    let categoryName : String
    var items  = [Food]()
    var itemPage : Int
    let query : String
    
    
    init?(jsonObject json : JSON) {
        self.categoryName = json["categoryname"].stringValue
        self.itemPage = json["itempage"].intValue
        self.query = json["query"].stringValue
        print(json["items"])
        
        guard json["items"] != JSON.null else {
            print("json[items] is null")
            return
        }
        
        for item in json["items"].arrayValue {
            guard let food = Food(json: item) else {
                print("food item wasnt able to init within the item class.")
                return
            }
            items.append(food)
        }
    }
}
