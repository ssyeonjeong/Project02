//
//  DetailViewController.swift
//  Project
//
//  Created by SWUCOMPUTER on 2017. 12. 10..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet var textName: UITextField!
    @IBOutlet var textBrand: UITextField!
    @IBOutlet var textCategory: UITextField!
    @IBOutlet var textDate: UITextField!
    @IBOutlet var textMemo: UITextView!
    
    var detail: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        if let display = detail {
            textName.text = display.value(forKey: "name") as? String
            textBrand.text = display.value(forKey: "brand") as? String
            textCategory.text = display.value(forKey: "category") as? String
            textMemo.text = display.value(forKey: "memo") as? String
            textDate.text = display.value(forKey: "date") as? String
        }
 

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

