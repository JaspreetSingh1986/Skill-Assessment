//
//  CategoryModal.swift
//  HeadyDemo
//
//  Created by Jaspreet on 16/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit
import RealmSwift
class MostViewedProducts : Object {
    @objc dynamic var  view_count      = 0
    @objc dynamic var  id              = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}
class MostOrdeRedProducts : Object {
    @objc dynamic var  order_count      = 0
    @objc dynamic var  id              = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}
class MostShaRedProducts : Object {
    @objc dynamic var  shares      = 0
    @objc dynamic var  id              = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}
class Categories : Object {
    @objc dynamic var  name            =  ""
    @objc dynamic var  id              = 0
    let products = List<Products>()
    let child_categories = List<Int>()
    override class func primaryKey() -> String? {
        return "id"
    }
}
class Products : Object {
    @objc dynamic var  name            =  ""
    @objc dynamic var  id              =  0
    @objc dynamic var  date_added      =  ""
    //    let tax                            = List<tax>()
    let variants                       = List<variants>()
    override class func primaryKey() -> String? {
        return "id"
    }
}
class tax : Object {
    @objc dynamic var  value     =  0.0
    @objc dynamic var  name      =  ""
}
class variants : Object {
    @objc dynamic var  color      =  ""
    @objc dynamic var  id         =  0
    let  price      =  RealmOptional<Int>();
    let size                    = RealmOptional<Int>();
}
class child_categories : Object {
}
class CategoryModal: NSObject {
    @IBOutlet weak var  categoryApi: CategoryApi!
    var categoriesArray = Array<Any>()
    
    //Mark:- getCategoriesRequest
    func getCategoriesRequest(completion: @escaping (AnyObject?) -> Void){
        categoryApi.categoryApiCall { (objectValue) in
            let matchedUsers = try! Realm().objects(Categories.self)
            self.categoriesArray = Array(matchedUsers)
            completion(nil)
        }
    }
    //Mark:-numberOfRows
    func numberOfRows() -> Int {
        return categoriesArray.count
    }
    //Mark:-cellForSettingListTblView
    func cellForList(tableView : UITableView,index: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: index) as! CategoryCell
        let object = categoriesArray[index.row] as! Categories
        cell.categoryLbl.text = object.name
        return cell
    }
    //Mark:-didSelect
    func didSelect(index: IndexPath) -> Categories {
        return categoriesArray[index.row] as! Categories
    }
}


