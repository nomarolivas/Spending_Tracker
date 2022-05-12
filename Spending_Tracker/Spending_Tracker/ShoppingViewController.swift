//  Created by Nomar Olivas on 4/21/22.
//

import UIKit
import CoreData

//Protocal that allows us to use the addNewAmount func from TrackerViewController

protocol ShoppingAmountSettingDelegate: AnyObject {
    func addNewAmount(_ newAmount: Float)
}

class ShoppingViewController: UIViewController {
    
    // Initialize the deleagte that's in the protocol
    weak var delegate: ShoppingAmountSettingDelegate? = nil
    
    // Float variable that keeps track of amount spent on Shopping and Entertainment
    var shoppingTotalAmount : Float = 0.00
    
    
    override func viewDidLoad() {
        //Allows us to load in the data when the view is loaded
        getData()
        ShoppingTotalAmount.text = String(format: "$%.02f", shoppingTotalAmount)
        super.viewDidLoad()
        
    }
    
    //Label for amount
    @IBOutlet weak var ShoppingTotalAmount: UILabel!
    
    //Textfield for user input
    @IBOutlet weak var UserAmountInput: UITextField!
    
    // Add button that updates the total amount for Shopping and the overall total
    // amount on the TrackerViewController
    @IBAction func AddAmountButton(_ sender: Any) {
//        print(shoppingTotalAmount)
        
        //Turns user input text into a string
        guard let userInput = UserAmountInput.text else {
            return
        }
        //Allows us to convert string into a Float
        guard let newAddedAmount = Float(userInput) else {
            return
        }
        
        //Passes new amount to other delegate
        delegate?.addNewAmount(newAddedAmount)
        addNewAmount(newAddedAmount)
        //Dismisses the ShoppingViewController after we add the amount
        dismiss(animated: true, completion: nil)
    }
    
    //Function that increases the shoppingTotalAmount and stores the amount in AmountData CoreData
    func addNewAmount(_ newAmount: Float){
        shoppingTotalAmount += newAmount //How we add up new amount
//        print(shoppingTotalAmount)
        ShoppingTotalAmount.text = String(format: "$%.02f", shoppingTotalAmount)
        
        //Allows us to save the shoppingTotalAmount to the AmountData CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingAmount", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)

        newEntity.setValue(shoppingTotalAmount, forKey: "shoppingTotal")

        do {
            try context.save()
            print("Data was saved")
        } catch {
            print("Faild Saving Data")
        }
    }
    
    //Function that retireves the data from our CoreData, specifically the ShoppingAmount Entity
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingAmount")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                shoppingTotalAmount = data.value(forKey: "shoppingTotal") as! Float
            }
        } catch {
            print("Fetching data failed")
        }
    }
    
}
