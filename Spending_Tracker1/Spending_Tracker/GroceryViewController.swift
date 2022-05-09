//
//  GroceryViewController.swift
//  Spending_Tracker
//
//  Created by Nomar Olivas on 5/7/22.
//

import UIKit

protocol GroceryAmountSettingDelegate: AnyObject {
    func addNewAmount(_ newAmount: Float)
    
}


class GroceryViewController: UIViewController {
    // 2. Initialize the deleagte 
    weak var delegate: GroceryAmountSettingDelegate? = nil
    
    var groceryTotalAmount : Float = 0.00
   

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //Label for amount which is 0.00 for now
    @IBOutlet weak var GroceryTotalAmount: UILabel!
    
    
    //Textfield for user input
    @IBOutlet weak var userAmountInput: UITextField!
    
    
    
    
    // 1. Add button at bottom
    @IBAction func AddAmountButton(_ sender: Any) {
        print(groceryTotalAmount)
        //Make user input text filed into a string
        guard let userInput = userAmountInput.text else {
            return
        }
        
        //Allows us to convert string into a Float
        guard let newAddedAmount = Float(userInput) else {
            return
        }
        
        //3. Pass new amount to other delegate
        delegate?.addNewAmount(newAddedAmount)
        
//        groceryTotalAmount += newAmount //How we add up new amount
//        GroceryTotalAmount.text = String(format: "$%.02f", groceryTotalAmount)
        
        addNewAmount(newAddedAmount)
        dismiss(animated: true, completion: nil)
        
        
    }
    //Left off here!!!!@@@@@@
    func addNewAmount(_ newAmount: Float){
        groceryTotalAmount += newAmount //How we add up new amount
        print(groceryTotalAmount)
        GroceryTotalAmount.text = String(format: "$%.02f", groceryTotalAmount)
//        GroceryTotalAmount.text = "25"
        
    }
    
    

    
    
    
}
