//
//  SelectWCViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 5/9/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import UIKit
import CoreData

class SelectWCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var wageClasses = [WageClass]()
    var proposalObject: Proposal?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWageClasses()
        self.tableView.allowsMultipleSelection = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wageClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddWageClassCell2", for: indexPath)
        
        let wageClass = wageClasses[indexPath.row]
        
        
        
        
        cell.textLabel?.text = wageClass.value(forKey: "wageClassName") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        let wageClassObject = self.wageClasses[indexPath.row]
        
        
        proposalObject?.addToWageClasses(wageClassObject)
        
        
        
        //        context.performAndWait({
        //
        //
        //
        //        do {
        //            try
        //
        adD.saveContext()
        //
        //
        //        } catch let error as NSError {
        //            print("Cannot save object: \(error), \(error.localizedDescription)")
        //        }
        //              })
        //
        
    }
    func getWageClasses(){
        let fetchRequest: NSFetchRequest<WageClass> = WageClass.fetchRequest()
        
        do {
            try self.wageClasses = context.fetch(fetchRequest)
            
        } catch {
            // handle error
        }
        
    }
    
    @IBAction func enterPressed(_ sender: UIButton) {
        
        
        let myResultsVC = storyboard?.instantiateViewController(withIdentifier: "RollUpVC") as! RollUpViewController
        //
        //
        //        myVC.proposalNamePassed = proposal.proposalName!
        //
        //
        // myVC.totalNumWorkersPassed = "\((proposal.value(forKeyPath: "wageClasses.@sum.numberOfWorkers") as! NSNumber).doubleValue)"
        
        myResultsVC.proposalObject = proposalObject
        navigationController?.pushViewController(myResultsVC, animated: true)
    }
    

  
        
   
    
    
    
}
