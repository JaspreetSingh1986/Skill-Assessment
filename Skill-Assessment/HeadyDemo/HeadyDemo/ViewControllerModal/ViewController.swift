//
//  ViewController.swift
//  HeadyDemo
//
//  Created by Jaspreet on 16/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var  categoryModal: CategoryModal!
    @IBOutlet weak var  myTableView: UITableView!
    var categoryObj: Categories!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "productList") {
            if let nextViewController = segue.destination as? ProductsVC {
                nextViewController.categoryObj =  categoryObj
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        categoryModal.getCategoriesRequest { (object) in
            self.myTableView.reloadData()
        }
    }
}
extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModal.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return categoryModal.cellForList(tableView:tableView, index:indexPath)
    }
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryObj = categoryModal.didSelect(index:indexPath)
        self.performSegue(withIdentifier: "productList", sender: self)
    }
}



