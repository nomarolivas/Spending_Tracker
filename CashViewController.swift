//  Created by Nomar Olivas on 4/21/22.
//

import UIKit
import CoreData

//Protocal that allows us to use the addNewAmount func from TrackerViewController

protocol CashSettingDelegate: AnyObject {
    func addNewAmount(_ newAmount: Float)
    
}

class CashViewController: UIViewController {
    
    // Initialize the deleagte that's in the protocol
    weak var delegate: CashSettingDelegate? = nil
    
    // Float variable that keeps track of amount spent on getting Cash out,
    // writing checks, and other uses
    var etcAmount : Float = 0.00
    
    
    override func viewDidLoad() {
        //Allows us to load in the data when the view is loaded
        getData()
        EtcTotalAmount.text = String(format: "$%.02f", etcAmount)
        super.viewDidLoad()
    }
    
    //Label for amount
    @IBOutlet weak var EtcTotalAmount: UILabel!
    
    //Textfield for user input
    @IBOutlet weak var UserAmountInput: UITextField!
    
    
    // Add button that updates the total amount for getting Cash out,
    // writing checks, and other uses along with the overall total
    // amount on the TrackerViewController
    @IBAction func AddAmountButton(_ sender: Any) {
//        print(etcAmount)
        
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
        //Dismisses the CashViewController after we add the amount
        dismiss(animated: true, completion: nil)
    }
    
    //Function that increases the etcAmount and stores the amount in AmountData CoreData
    func addNewAmount(_ newAmount: Float){
        etcAmount += newAmount //How we add up new amount
//        print(etcAmount)
        EtcTotalAmount.text = String(format: "$%.02f", etcAmount)
        
        //Allows us to save the etcAmount to the AmountData CoreData
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "EtcAmount", in: context)
            let newEntity = NSManagedObject(entity: entity!, insertInto: context)

            newEntity.setValue(etcAmount, forKey: "etcAmount")

            do {
                try context.save()
                print("Data was saved")
            } catch {
                print("Faild Saving Data")
            }
    }
    
    //Function that retireves the data from our CoreData, specifically the EtcAmount Entity
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EtcAmount")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                etcAmount = data.value(forKey: "etcAmount") as! Float
            }
        } catch {
            print("Fetching data failed")
        }
    }
    
    
    
    
}
