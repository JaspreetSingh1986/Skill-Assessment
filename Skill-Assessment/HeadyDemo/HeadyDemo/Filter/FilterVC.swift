//
//  FilterVC.swift
//  HeadyDemo
//
//  Created by Jaspreet on 17/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit
protocol FilterDelegate: class {
    func changeFilter(color : String, size: String , price: String)
}

class FilterVC: UIViewController {
    @IBOutlet weak var filterModal: FilterModal!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var sizeTxt: UITextField!
    @IBOutlet weak var colorTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    
    var activeField: UITextField!
    var childProductArray = NSMutableArray()
    var categoryObj: Categories!
    
    weak var delegate : FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
        filterModal.getFilterValues(products: categoryObj.products)
        filterModal.getFilterValues(childProducts: childProductArray)
        
        myPickerView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 216)
        myPickerView.backgroundColor = .white
        myPickerView.showsSelectionIndicator = true
        
        sizeTxt.inputView     = myPickerView
        colorTxt.inputView    = myPickerView
        priceTxt.inputView    = myPickerView
        myPickerView.reloadAllComponents()
        // Do any additional setup after loading the view.
    }
    //MARK:- ReloadPickerAfterDelay
    @objc func delayedAction() {
        myPickerView.reloadAllComponents()
        myPickerView.selectRow(0, inComponent: 0, animated: true)
        myPickerView.reloadAllComponents()
        
    }
    //MARK:- addQuote
    @IBAction func submitClick(_ sender: UIButton!) {
        delegate?.changeFilter(color: colorTxt.text ?? "", size: sizeTxt.text ?? "", price: priceTxt.text ?? "")
        self.navigationController?.popViewController(animated: true)
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
//MARK:- TextFieldDelegate
extension FilterVC: UITextFieldDelegate {
    //MARK:- textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK:- textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeField == sizeTxt {
            if activeField.text?.count == 0 {
                if filterModal.arraySize.count > 0 {
                                        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
                }
            }
        }
        else if activeField == colorTxt {
            if activeField.text?.count == 0 {
                if filterModal.arrayColor.count > 0 {
                    Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)

                }
            }
        }
        else if activeField == priceTxt {
            if activeField.text?.count == 0 {
                if filterModal.arrayPrice.count > 0 {
                    Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
                }
            }
        }
        myPickerView.reloadAllComponents()
        self.activeField = nil
    }
    //MARK:- textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
        
    }
}
extension FilterVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeField == colorTxt {
            if filterModal.arrayColor.count > 0 {
                return  filterModal.arrayColor.count
            }
        }
        else if activeField == sizeTxt  {
            if filterModal.arraySize.count > 0 {
                return  filterModal.arraySize.count
            }
        }
        else   {
            if filterModal.arrayPrice.count > 0 {
                return  filterModal.arrayPrice.count
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeField == colorTxt {
            if filterModal.arrayColor.count > row {
                return filterModal.getColorName(row: row)
            }
        }
        else if activeField == sizeTxt  {
            if filterModal.arraySize.count > row {
                return filterModal.getSizeName(row: row)
            }
        }
        else  {
            if filterModal.arrayPrice.count > 0 {
                return filterModal.getPriceName(row: row)
            }
        }
        return ""
    }
}
extension FilterVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeField == colorTxt {
            if filterModal.arrayColor.count > row {
                colorTxt.text = filterModal.getColorName(row: row)
            }
        }
        else if activeField == sizeTxt  {
            if filterModal.arraySize.count > row {
                sizeTxt.text = filterModal.getSizeName(row: row)
            }
        }
        else {
            if filterModal.arrayPrice.count > row {
                priceTxt.text = filterModal.getPriceName(row: row)
            }
        }
    }
}


