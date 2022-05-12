//  Created by Nomar Olivas on 4/21/22.
//

import UIKit
import CoreData

//Protocal that allows us to use the addNewAmount func from TrackerViewController

protocol ResturantAmountSettingDelegate: AnyObject {
    func addNewAmount(_ newAmount: Float)
}

class ResturantViewController: UIViewController {
    
    // Float variable that keeps track of amount spent on Resturant and Dining
    var resturantDiningAmount : Float = 0.00
    
    // Initialize the deleagte that's in the protocol
    weak var delegate: ResturantAmountSettingDelegate? = nil
    
    
    override func viewDidLoad() {
        //Allows us to load in the data when the view is loaded
        getData()
        ResturantTotalAmount.text = String(format: "$%.02f", resturantDiningAmount)
        super.viewDidLoad()
    }
    
    //Label for amount
    @IBOutlet weak var ResturantTotalAmount: UILabel!
    
    //Textfield for user input
    @IBOutlet weak var UserAmountInput: UITextField!
    
    
    // Add button that updates the total amount for Resturant and the overall total
    // amount on the TrackerViewController
    @IBAction func AddAmountButton(_ sender: Any) {
//        print(resturantDiningAmount)
        
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
        //Dismisses the ResturantViewController after we add the amount
        dismiss(animated: true, completion: nil)
        
    }
    
    //Function that increases the resturantDiningAmount and stores the amount in AmountData CoreData
    func addNewAmount(_ newAmount: Float){
        resturantDiningAmount += newAmount //How we add up new amount
//        print(resturantDiningAmount)
        ResturantTotalAmount.text = String(format: "$%.02f", resturantDiningAmount)
        
        //Allows us to save the resturantDiningAmount to the AmountData CoreData
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "ResturantAmount", in: context)
            let newEntity = NSManagedObject(entity: entity!, insertInto: context)

            newEntity.setValue(resturantDiningAmount, forKey: "resturantTotal")

            do {
                try context.save()
                print("Data was saved")
            } catch {
                print("Faild Saving Data")
            }
    }
    
    //Function that retireves the data from our CoreData, specifically the ResturantAmount Entity
    func getData() {

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ResturantAmount")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                resturantDiningAmount = data.value(forKey: "resturantTotal") as! Float
            }
        } catch {
            print("Fetching data failed")
        }
    }
}
