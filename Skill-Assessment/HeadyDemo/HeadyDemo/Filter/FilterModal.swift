//
//  FilterModal.swift
//  HeadyDemo
//
//  Created by Jaspreet on 17/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit
import RealmSwift
class FilterModal: NSObject {
    var arraySize  = Array<Any>()
    var arrayColor = Array<Any>()
    var arrayPrice = Array<Any>()
    let arraySizeMutable = NSMutableArray()
    let arrayColorMutable = NSMutableArray()
    let arrayPriceMutable = NSMutableArray()
    func getFilterValues(products: List<Products>) {
        for i in 0..<products.count {
            let product =  products[i]
            let variants =  product.variants
            for variant in variants {
                if let value =  variant.size.value {
                arraySizeMutable.add(String(describing:value))
                }
                arrayColorMutable.add(variant.color)
                if let priceValue =  variant.price.value {
                print(priceValue)
                arrayPriceMutable.add(String(describing: priceValue))
                }
            }
        }
        arraySize  = Array(NSMutableOrderedSet(array: arraySizeMutable as! [Any]))
        arrayColor = Array(NSMutableOrderedSet(array: arrayColorMutable as! [Any]))        
        arrayPrice = Array(NSMutableOrderedSet(array: arrayPriceMutable as! [Any]))
    }
    func getFilterValues(childProducts: NSMutableArray) {
        for i in 0..<childProducts.count {
            
            let product =  childProducts[i]  as! Products
            let variants =  product.variants
            for variant in variants {
                if let value =  variant.size.value {
                    arraySizeMutable.add(String(describing:value))
                }
                arrayColorMutable.add(variant.color)
                if let priceValue =  variant.price.value {
                    print(priceValue)
                    arrayPriceMutable.add(String(describing: priceValue))
                }
            }
        }
        arraySize  = Array(NSMutableOrderedSet(array: arraySizeMutable as! [Any]))
        
        arrayColor = Array(NSMutableOrderedSet(array: arrayColorMutable as! [Any]))
        
        arrayPrice = Array(NSMutableOrderedSet(array: arrayPriceMutable as! [Any]))
    }
    func getColorName(row: Int) -> String {
        return arrayColor[row] as! String
    }
    func getPriceName(row: Int) -> String {
        if arrayPrice.count > row {
        return arrayPrice[row] as! String
        }
        else {
            return ""
        }
    }
    func getSizeName(row: Int) -> String {
        return arraySize[row] as! String
    }
}
