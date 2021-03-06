//
//  AddThreeViewController.swift
//  Project
//
//  Created by SWUCOMPUTER on 2017. 12. 10..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class AddThreeViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var textName: UITextField!
    @IBOutlet var textBrand: UITextField!
    @IBOutlet var textCategory: UITextField!
    @IBOutlet var textDate: UITextField!
    @IBOutlet var textMemo: UITextView!
    
    var pickerUniv = UIPickerView()
    var pickerDate = UIDatePicker()

    
    let list3Array = ["브러쉬","퍼프/스펀지","렌즈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pickerUniv.dataSource = self
        pickerUniv.delegate = self
        textCategory.inputView = pickerUniv
        
        pickerDate.datePickerMode = .date
        textDate.inputView = pickerDate
        
        
        let bar = UIToolbar()
        bar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButton))
        bar.setItems([done], animated: false)
        
        textCategory.inputAccessoryView = bar
        textDate.inputAccessoryView = bar
        
    }
    
    func doneButton() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        textDate.text = dateFormatter.string(from: pickerDate.date)
        
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list3Array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list3Array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textCategory.text = list3Array[row]
    }

  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    @IBAction func thirdSave(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Tool", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(textName.text, forKey: "name")
        object.setValue(textBrand.text, forKey: "brand")
        object.setValue(textMemo.text, forKey: "memo")
        object.setValue(textDate.text, forKey: "date")
        object.setValue(textCategory.text, forKey: "category")
        object.setValue(Date(), forKey: "saveDate")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)

    }

}
