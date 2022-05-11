//  Created by Nomar Olivas on 4/15/22.

import UIKit

protocol AdditionSetDelegate {
    func AddAmount(_ newAmount: Float)
}

struct CategoriesForPicker: Hashable  {
    let name: String
    let amount: Float
}



class AdditionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var delegate: TrackerViewController? = nil
    
    
    //This one works
    var categoriesForPicker: [CategoriesForPicker] = [
        CategoriesForPicker(name: "Select... ", amount: 0),
        CategoriesForPicker(name: "Groceries", amount: 0),
        CategoriesForPicker(name: "Restaurant and Dining", amount: 0),
        CategoriesForPicker(name: "Shopping and Entertainment" , amount: 0),
        CategoriesForPicker(name: "Cash, Checks, other", amount: 0),
    ]

//    let pickerData = ["Select... ", "Groceries", "Restaurant and Dining", "Shopping and Entertainment", "Cash, Checks, other" ]


    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryPicker.delegate = self
        CategoryPicker.dataSource = self
    }

    //Picker starts here
    @IBOutlet weak var CategoryPicker: UIPickerView!

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let cell = UITableViewCell()
        let row = row
        let items = categoriesForPicker[row]
        cell.textLabel?.text = items.name
        return items.name

    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        updateLabel()
    }
    
    func updateLabel() {
//    let selection = categoriesForPicker[0][CategoryPicker.selectedRowInComponent(0)]
    
    
    }
    


    
    

    
    //Picker ends here
    
    
    //Text Field Starts here
    @IBOutlet weak var AmountEntered: UITextField!
    
    
    //Add button starts here
    @IBAction func AddAmountPressed(_ sender: Any) {
        guard let userInput = AmountEntered.text else {
            return
        }
        
        guard let newAmount = Float(userInput) else {
            return
        }
        
        delegate?.totalAmountSet(newAmount)
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    

    
    
    
}



//let userInput: String? = AmountEntered.text
//
//if let stringAmount = userInput {
//    if let floatAmount = Float(stringAmount) {
//        let result = floatAmount
//        //See vid on how to send floatAmount to the other screen
//    }
//}
