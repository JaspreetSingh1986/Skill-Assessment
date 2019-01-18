//
//  ProductModal.swift
//  HeadyDemo
//
//  Created by Jaspreet on 16/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit
import RealmSwift
class ProductModal: NSObject {
    var productsArray = Array<Any>()
    var childProductArray = NSMutableArray()
    func getChildProductArray(category :Categories) {
        for i in 0..<category.child_categories.count {
            let object = category.child_categories[i]
            let string = "id = " + String(object)
            print(string)
            let matchedUsers = try! Realm().objects(Products.self).filter(string)
            for i in 0..<matchedUsers.count {
                let object = matchedUsers[i]
                childProductArray.add(object)
            }
        }
    }
    func getValueChild(category :Categories,size: String, color: String, price: String) {
        for i in 0..<category.child_categories.count {
            let object = category.child_categories[i]
            var string  = ""
            string = "id = " + String(object) + "&&ANY variants.size == " + size + "&&ANY variants.color == " + color +  "&&ANY variants.price == " + price
            let matchedUsers = try! Realm().objects(Products.self).filter(string)
            for i in 0..<matchedUsers.count {
                let object = matchedUsers[i]
                childProductArray.add(object)
            }
        }
    }
    

    //Mark:- getCategoriesRequest
    func numberOfRows(category :Categories) -> Int {
        if category.child_categories.count > 0 {
            return childProductArray.count
        }
        else  {
            return category.products.count
        }
    }
    //Mark:-cellForSettingListTblView
    func cellForList(category :Categories,tableView : UITableView,index: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: index) as! ProductCell
        if self.childProductArray.count > 0 {
            print(self.childProductArray[index.row])
            let obj = self.childProductArray[index.row] as! Products
            cell.productName.text = obj.name
            cell.productDate.text =  obj.date_added
        }
        else  {
            let obj = category.products[index.row]
            cell.productName.text = obj.name
            cell.productDate.text =  obj.date_added
        }
        return cell
    }
    //Mark:-didSelect
    func didSelect(category :Categories, index: IndexPath) -> Categories {
        return productsArray[index.row] as! Categories
    }
}

