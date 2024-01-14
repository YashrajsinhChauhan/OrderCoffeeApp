//
//  OrderViewController.swift
//  Yashrajsinh_MyOrder
//
//  Created by user217595 on 5/16/22.
//

import UIKit

class OrderViewController: UIViewController {
    
    private let dbHelper = CoreDBHelper.getInstance()
    
    var coffeeTypeSelected:String = ""
    var coffeeSizeSelected:String = ""
    
    
    @IBOutlet weak var quantitySelected: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func coffeeTypeSelected(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
           coffeeTypeSelected  = "Dark Roast"
        }
        else if sender.selectedSegmentIndex == 1 {
            
           coffeeTypeSelected = "Original Blend"
        }
        else if sender.selectedSegmentIndex == 2 {
            
            coffeeTypeSelected = "Vanilla"
        }
    }
    
    

    @IBAction func coffeeSizeSelected(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
           coffeeSizeSelected  = "Small"
        }
        else if sender.selectedSegmentIndex == 1 {
            
           coffeeSizeSelected = "Medium"
        }
        else if sender.selectedSegmentIndex == 2 {
            
            coffeeSizeSelected = "Large"
        }

    }
    
    
    @IBAction func addOrderPressed(_ sender: Any) {
        
        addOrderToList(coffeeType: coffeeTypeSelected, coffeeSize: coffeeSizeSelected, quantity: quantitySelected.text ?? "1")
        
        quantitySelected.text = ""
    }
    
    private func addOrderToList(coffeeType: String, coffeeSize: String, quantity: String){
        
        self.dbHelper.insertTask(coffeeType: coffeeType, coffeeSize: coffeeSize, quantity: quantity)
        
    }
    
}
