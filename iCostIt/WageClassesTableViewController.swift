//
//  WageClassesTableViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 12/5/16.
//  Copyright © 2016 com.millionacrenest. All rights reserved.
//

import UIKit
import CoreData


class WageClassesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    var controller: NSFetchedResultsController<WageClass>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    //   generateTestData()
        attemptFetch()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WageClassCell", for: indexPath) as! WageCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
            
        }
        return 0
    }
    
    
    func configureCell(cell: WageCell, indexPath: NSIndexPath) {
        
        let wageClass = controller.object(at: indexPath as IndexPath)
        cell.configureCell(wageClass: wageClass)
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects , objs.count > 0 {
            
            let wageClass = objs[indexPath.row]
            performSegue(withIdentifier: "WageClassDetailVC", sender: wageClass)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WageClassDetailVC" {
            if let destination = segue.destination as? WageClassesDetailViewController {
                if let wageClass = sender as? WageClass {
                    destination.wageClassToEdit = wageClass
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<WageClass> = WageClass.fetchRequest()
//        let dateSort = NSSortDescriptor(key: "dateCreated", ascending: true)
        let nameSort = NSSortDescriptor(key: "wageClassName", ascending: true)
//        let costSort = NSSortDescriptor(key: "pensionContribution", ascending: false)
        
//        if segmentedControl.selectedSegmentIndex == 0 {
//            fetchRequest.sortDescriptors = [costSort]
//        } else if segmentedControl.selectedSegmentIndex == 1 {
//            fetchRequest.sortDescriptors = [nameSort]
//            
//        } else if segmentedControl.selectedSegmentIndex == 2 {
//            fetchRequest.sortDescriptors = [dateSort]
//        }
        
        fetchRequest.sortDescriptors = [nameSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type){
            
        case.insert:
            if let indexPath = newIndexPath {
                
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                
                
               
                
            
            
            if let cell = tableView.cellForRow(at: indexPath) as? WageCell {
                 configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            } else {
                print("model id is nil")
            }
            
            }
            
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
        
    }
    
    func generateTestData() {
        
        
        
        let wageClassA = WageClass(context: context)
        wageClassA.wageClassName = "Sample WageClassA"
        wageClassA.numberOfWorkers = 55.00
        wageClassA.wagePerHour = 5.75
       wageClassA.setValue(false,forKey:"checked")
        
        let wageClassB = WageClass(context: context)
        wageClassB.wageClassName = "Sample WageClassB"
        wageClassB.numberOfWorkers = 80.00
        wageClassB.wagePerHour = 6.25
       wageClassB.setValue(false,forKey:"checked")
        
        let wageClassC = WageClass(context: context)
        wageClassC.wageClassName = "Sample WageClassC"
        wageClassC.numberOfWorkers = 25.00
        wageClassC.wagePerHour = 6.75
        wageClassC.setValue(false,forKey:"checked")
        
        let wageClassD = WageClass(context: context)
        wageClassD.wageClassName = "Sample WageClassD"
        wageClassD.numberOfWorkers = 40.00
        wageClassD.wagePerHour = 7.00
        wageClassD.setValue(false,forKey:"checked")
        
        let wageClassE = WageClass(context: context)
        wageClassE.wageClassName = "Sample WageClassE"
        wageClassE.numberOfWorkers = 60.00
        wageClassE.wagePerHour = 7.50
        wageClassE.setValue(false,forKey:"checked")
        
        let wageClassF = WageClass(context: context)
        wageClassF.wageClassName = "Sample WageClassF"
        wageClassF.numberOfWorkers = 40.00
        wageClassF.wagePerHour = 8.00
        wageClassF.setValue(false,forKey:"checked")
        
        
        
        
        adD.saveContext()
        
    }
    
    
}
