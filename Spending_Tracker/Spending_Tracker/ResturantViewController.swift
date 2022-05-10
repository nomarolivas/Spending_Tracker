//
//  ResturantViewController.swift
//  Spending_Tracker
//
//  Created by Nomar Olivas on 5/7/22.
//

import UIKit
import CoreData



protocol ResturantAmountSettingDelegate: AnyObject {
    func addNewAmount(_ newAmount: Float)
}

class ResturantViewController: UIViewController {
    
    var resturantDiningAmount : Float = 0.00
    weak var delegate: ResturantAmountSettingDelegate? = nil
    
    
    override func viewDidLoad() {
        getData()
        ResturantTotalAmount.text = String(format: "$%.02f", resturantDiningAmount)
        
        super.viewDidLoad()
        
    }
    
    
    @IBOutlet weak var ResturantTotalAmount: UILabel!
    
    
    @IBOutlet weak var UserAmountInput: UITextField!
    
    
    
    @IBAction func AddAmountButton(_ sender: Any) {
        print(resturantDiningAmount)
        
        guard let userInput = UserAmountInput.text else {
            return
        }
        
        //Allows us to convert string into a Float
        guard let newAddedAmount = Float(userInput) else {
            return
        }
        
        delegate?.addNewAmount(newAddedAmount)
        
        addNewAmount(newAddedAmount)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func addNewAmount(_ newAmount: Float){
        resturantDiningAmount += newAmount //How we add up new amount
        print(resturantDiningAmount)
        ResturantTotalAmount.text = String(format: "$%.02f", resturantDiningAmount)
        
        //Just added this to add data to database
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Amounts", in: context)
            let newEntity = NSManagedObject(entity: entity!, insertInto: context)

            newEntity.setValue(resturantDiningAmount, forKey: "resturantAmount")

            do {
                try context.save()
                print("Data was saved")
            } catch {
                print("Faild Saving Data")
            }
       //Ends here
        
    }
    
    //Ended here!!!!!!!!!!!!!
    
    func getData() {

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Amounts")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                resturantDiningAmount = data.value(forKey: "resturantAmount") as! Float
            }
        } catch {
            print("Fetching data failed")
        }
    }
    
    
    
}
