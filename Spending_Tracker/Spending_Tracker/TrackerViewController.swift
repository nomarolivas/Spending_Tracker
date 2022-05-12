//  Created by Nomar Olivas on 4/15/22.
import UIKit
import CoreData

//Struct that stores Categories for each category of spending
struct Categories: Hashable {
    let name: String
    
}

class TrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GroceryAmountSettingDelegate, ResturantAmountSettingDelegate, ShoppingAmountSettingDelegate, CashSettingDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        //Allows us to load in the data when the view is loaded
        getData()
        totalOutput.text = String(format: "$%.02f", totalAmountSpent)
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    //TableView code starts here
    
    //Created a table view for each Spending Category
    @IBOutlet weak var tableView: UITableView!
    
    //Array used to store each Category's name
    var categories: [Categories] = [
        Categories(name: "Groceries"),
        Categories(name: "Restaurant and Dining"),
        Categories(name: "Shopping and Entertainment"),
        Categories(name: "Cash, Checks, other"),
    ]
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        let items = categories[row]
        
        //Adds images based on category for each cell
        let name = items.name
        let image = UIImage(named: name)
        cell.textLabel?.text = items.name
        cell.imageView?.image = image
        
        //Sets cell background color
        cell.contentView.backgroundColor = UIColor.systemGray5
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    //Allows us to select a row and segues to the view controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let indexPath = tableView.indexPathForSelectedRow!

        if(indexPath.row == 0){
            performSegue(withIdentifier: "ToGrocerySegue", sender: index)
            let vc = GroceryViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if(indexPath.row == 1){
            performSegue(withIdentifier: "ResturantSegue", sender: index)
            let vc = ResturantViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if(indexPath.row == 2){
            performSegue(withIdentifier: "ShoppingSegue", sender: index)
            let vc = ShoppingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if(indexPath.row == 3){
            performSegue(withIdentifier: "CashSegue", sender: index)
            let vc = CashViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //Allows us to segue to each viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let groceryVC = segue.destination as? GroceryViewController {
            groceryVC.delegate = self
            
        }else if let resturantVC = segue.destination as? ResturantViewController {
            resturantVC.delegate = self
        }else if let shoppingVC = segue.destination as? ShoppingViewController{
            shoppingVC.delegate = self
            
        }else if let etcVC = segue.destination as? CashViewController{
            etcVC.delegate = self
        }
    }
    //TableView code ends here
    
    
    
    //Label that displays the Total Amount on Main Screen
    @IBOutlet weak var totalOutput: UILabel!
    var totalAmountSpent : Float = 0.00
    
    
    
    //Function for adding new amounts
    func addNewAmount(_ newAmount: Float){
        //Adds new amount from other viewControllers
        totalAmountSpent += newAmount
        totalOutput.text = String(format: "$%.02f", totalAmountSpent)
        
        //Allows us to save the totalAmount to the AmountData CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "TotalAmount", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(totalAmountSpent, forKey: "totalAmount")

        do {
            try context.save()
//            print("Data was saved")
        } catch {
            print("Faild Saving Data")
        }
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TotalAmount")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                totalAmountSpent = data.value(forKey: "totalAmount") as! Float
            }
        } catch {
            print("Fetching data failed")
        }
    }
    
    //Button that resets all Amounts for each category and for the Total Amount
    @IBAction func ResetAllData(_ sender: Any) {
        
        //This deletes Total Amount Data
        let deleteEntireTotal = NSFetchRequest<NSFetchRequestResult>(entityName: "TotalAmount")
        let deleteRequestAllTotal = NSBatchDeleteRequest(fetchRequest: deleteEntireTotal)
        totalAmountSpent = 0
        totalOutput.text = String(format: "$%.02f", 0)
        
        //This deletes Grocery Amount Data
        let deleteGrocery = NSFetchRequest<NSFetchRequestResult>(entityName: "GroceryAmount")
        let deleteRequestGrocery = NSBatchDeleteRequest(fetchRequest: deleteGrocery)
        
        //This deletes Resturant Amount Data
        let deleteResturant = NSFetchRequest<NSFetchRequestResult>(entityName: "ResturantAmount")
        let deleteRequestRest = NSBatchDeleteRequest(fetchRequest: deleteResturant)
        
        //This deletes Shopping Amount Data
        let deleteShopping = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingAmount")
        let deleteRequestShop = NSBatchDeleteRequest(fetchRequest: deleteShopping)
        
        //This deletes Etc Amount Data
        let deleteETC = NSFetchRequest<NSFetchRequestResult>(entityName: "EtcAmount")
        let deleteRequestETC = NSBatchDeleteRequest(fetchRequest: deleteETC)
        
        //Executes the request to delete all Amounts in coreData
        do {
            try context.execute(deleteRequestGrocery)
            try context.save()
            
            try context.execute(deleteRequestRest)
            try context.save()
            
            try context.execute(deleteRequestAllTotal)
            try context.save()
            
            try context.execute(deleteRequestShop)
            try context.save()
            
            try context.execute(deleteRequestETC)
            try context.save()
            
        } catch {
            print ("There was an error")
        }
    }
    
    
    
}

