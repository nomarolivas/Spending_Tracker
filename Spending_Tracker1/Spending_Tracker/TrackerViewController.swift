//  Created by Nomar Olivas on 4/15/22.
import UIKit
import CoreData

struct Categories: Hashable {
    let name: String
    
}



class TrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GroceryAmountSettingDelegate {
    
//    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    // DON'T THINk we need this ^
    
//    private lazy var persistentContainer: NSPersistentContainer = {
//        NSPersistentContainer(name: "AmountsFoAll")
//    }()
    

        
        
        
    
    
    
    var groceryAmount : Float = 0.00
    var resturantDiningAmount : Float = 0.00
    var shoppingEntertainmentAmount : Float = 0.00
    var etcAmount : Float = 0.00

    //Table view code starts here
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Categories] = [
        Categories(name: "Groceries"),
        Categories(name: "Restaurant and Dining "),
        Categories(name: "Shopping and Entertainment "),
        Categories(name: "Cash, Checks, other"),
    ]
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        let items = categories[row]
        cell.textLabel?.text = items.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let indexPath = tableView.indexPathForSelectedRow!
//        print("index \(indexPath.row)") //Tells us which index of array we are going to
        
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
            let vc = ResturantViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if(indexPath.row == 3){
            performSegue(withIdentifier: "CashSegue", sender: index)
            let vc = ResturantViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
//                if let error = error {
//                    print("Unable to Add Persistent Store")
//                    print("\(error), \(error.localizedDescription)")
//
//                } else {
////                    print(persistentStoreDescription.url, persistentStoreDescription.type)
//            }
//        }
    }
      
    //Table view code ends here
    
    
    
    @IBOutlet weak var totalOutput: UILabel!
    
    
    
    var totalAmountSpent : Float = 0.00
    
    //1. Create new function for adding new amount from other screens
    func addNewAmount(_ newAmount: Float){
        totalAmountSpent += newAmount //How we add up new amount
        totalOutput.text = String(format: "$%.02f", totalAmountSpent)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let groceryVC = segue.destination as? GroceryViewController {
            groceryVC.delegate = self
            
        }else{
            //Add the other VCs here 
        }
        
    }
    
    //Added this rn
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
    }

    
    
}

