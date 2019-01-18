//
//  ProductsVC.swift
//  HeadyDemo
//
//  Created by Jaspreet on 16/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit

class ProductsVC: UIViewController,FilterDelegate {
    @IBOutlet weak var productModal: ProductModal!
    var categoryObj: Categories!
    @IBOutlet weak var   myTableView: UITableView!
    var filterObj : FilterVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Products"
        productModal.getChildProductArray(category: categoryObj)
        myTableView.reloadData()
        let filterButton = UIButton(type: UIButton.ButtonType.custom)
        filterButton.addTarget(self, action: #selector(ProductsVC.filter(_:)), for: UIControl.Event.touchUpInside)
        filterButton.setImage(UIImage.init(named: "filter"), for:  UIControl.State())
        filterButton.sizeToFit()
        let filterButtonItem = UIBarButtonItem(customView: filterButton)
        self.navigationItem.rightBarButtonItem = filterButtonItem
        // Do any additional setup after loading the view.
    }
    //MARK:- addQuote
    @objc func filter(_ sender: UIButton!) {
        self.performSegue(withIdentifier: "filter", sender: self)
    }
    func changeFilter(color: String, size: String, price: String) {
        print(color,size,price)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "filter") {
            if let nextViewController = segue.destination as? FilterVC {
                nextViewController.categoryObj =  categoryObj
                nextViewController.childProductArray =  productModal.childProductArray
                nextViewController.delegate =  self
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductsVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productModal.numberOfRows(category: categoryObj)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return productModal.cellForList(category: categoryObj, tableView:tableView, index:indexPath)
    }
}
extension ProductsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
