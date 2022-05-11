//  Created by Nomar Olivas on 4/21/22.

import UIKit
import CoreData

//Protocal that allows us to use the addNewAmount func from TrackerViewController
protocol GroceryAmountSettingDelegate: AnyObject {
    func addNewAmount(_ newAmount: Float)
}

class GroceryViewController: UIViewController {
    
    // Initialize the deleagte that's in the protocol
    weak var delegate: GroceryAmountSettingDelegate? = nil
    
    // Float variable that keeps track of amount spent on Groceries
    var groceryTotalAmount : Float = 0.00
    
    
    override func viewDidLoad() {
        //Allows us to load in the data when the view is loaded
        getData()
        GroceryTotalAmount.text = String(format: "$%.02f", groceryTotalAmount)
        super.viewDidLoad()
    }

    //Label for amount
    @IBOutlet weak var GroceryTotalAmount: UILabel!
    
    
    //Textfield for user input
    @IBOutlet weak var userAmountInput: UITextField!
    
    
    // Add button that updates the total amount for groceries and the overall total
    // amount on the TrackerViewController
    @IBAction func AddAmountButton(_ sender: Any) {
//        print(groceryTotalAmount)
        
        //Turns user input text into a string
        guard let userInput = userAmountInput.text else {
            return
        }
        
        //Allows us to convert string into a Float
        guard let newAddedAmount = Float(userInput) else {
            return
        }
        
        //Passes new amount to other delegate
        delegate?.addNewAmount(newAddedAmount)
        addNewAmount(newAddedAmount)
        //Dismisses the GroceryViewController after we add the amount
        dismiss(animated: true, completion: nil)
    }

    //Function that increases the grocerytotalAmount and stores the amount in AmountData CoreData
    func addNewAmount(_ newAmount: Float){
        groceryTotalAmount += newAmount //How we add up new amount
//        print(groceryTotalAmount)
        GroceryTotalAmount.text = String(format: "$%.02f", groceryTotalAmount)
        
            //Allows us to save the groceryTotalAmount to the AmountData CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "GroceryAmount", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
            newEntity.setValue(groceryTotalAmount, forKey: "groceryAmount")

            do {
                try context.save()
                print("Data was saved")
            } catch {
                print("Faild Saving Data")
            }
    }
    
    //Function that retireves the data from our CoreData, specifically the GroceryAmount Entity
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GroceryAmount")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                groceryTotalAmount = data.value(forKey: "groceryAmount") as! Float
            }
        } catch {
            print("Fetching data failed")
        }
    }

    
}
