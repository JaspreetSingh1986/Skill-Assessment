//
//  CategoryApi.swift
//  HeadyDemo
//
//  Created by Jaspreet on 16/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryApi: NSObject {
    func categoryApiCall(completion: @escaping (AnyObject?) -> Void){
        let url = URL(string: "https://stark-spire-93433.herokuapp.com/json")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard error == nil else {
                print("returning error")
                return
            }
            guard let content = data else {
                print("not returning data")
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            let jsonDict = json as NSDictionary
            let rankings =  jsonDict.value(forKey: "rankings") as! Array<Any>
            for ranking in rankings {
                let rankingDict  =  ranking as! NSDictionary
                let rankingName =  rankingDict.value(forKey: "ranking") as! String
                if rankingName == "Most OrdeRed Products" {
                    let productArray = rankingDict["products"] as! [NSDictionary]
                    let realm = try! Realm()
                    try! realm.write {
                        for venue in productArray {
                            realm.create(MostOrdeRedProducts.self, value: venue, update: true)
                        }
                    }
                }
                if rankingName == "Most ShaRed Products" {
                    let productArray = rankingDict["products"] as! [NSDictionary]
                    let realm = try! Realm()
                    try! realm.write {
                        for venue in productArray {
                            realm.create(MostShaRedProducts.self, value: venue, update: true)
                        }
                    }
                }
                if rankingName == "Most Viewed Products" {
                    let productArray = rankingDict["products"] as! [NSDictionary]
                    let realm = try! Realm()
                    try! realm.write {
                        for venue in productArray {
                            realm.create(MostViewedProducts.self, value: venue, update: true)
                        }
                    }
                }
            }
            let categories =  jsonDict.value(forKey: "categories") as! [NSDictionary]
            let realm = try! Realm()
            try! realm.write {
                for venue in categories {
                    realm.create(Categories.self, value: venue, update: true)
                }
            }
            DispatchQueue.main.async {
                completion(nil)
            }
            
        }
        task.resume()
    }
}

