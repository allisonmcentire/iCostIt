//
//  ProposalTableViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 12/8/16.
//  Copyright © 2016 com.millionacrenest. All rights reserved.
//

import UIKit
import CoreData


class ProposalTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    
    var controller: NSFetchedResultsController<Proposal>!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        generateTestData()
        attemptFetch()
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProposalCell", for: indexPath) as! ProposalCell
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
    
  
    
  
    
    func configureCell(cell: ProposalCell, indexPath: NSIndexPath) {
        
        let proposal = controller.object(at: indexPath as IndexPath)
        cell.configureCell(proposal: proposal)
        
   
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects , objs.count > 0 {
            
            let proposal = objs[indexPath.row]
            performSegue(withIdentifier: "ProposalDetailsVC", sender: proposal)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProposalDetailsVC" {
            if let destination = segue.destination as? ProposalDetailViewController {
                if let proposal = sender as? Proposal {
                    destination.proposalToEdit = proposal
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return
//    }
   
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Proposal> = Proposal.fetchRequest()
        let dateSort = NSSortDescriptor(key: "dateCreated", ascending: true)
        let nameSort = NSSortDescriptor(key: "proposalName", ascending: true)
        let costSort = NSSortDescriptor(key: "pensionContribution", ascending: false)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [costSort]
        } else if segmentedControl.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [nameSort]
            
        } else if segmentedControl.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [dateSort]
        }
        
        

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
    
    @IBAction func segmentedControl(_ sender: Any) {
        attemptFetch()
        tableView.reloadData()
        
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
                let cell = tableView.cellForRow(at: indexPath) as! ProposalCell
                
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
                
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
        
        
        
        let proposalA = Proposal(context: context)
      
        proposalA.proposalName = "Sample ProposalA"
        proposalA.percentIncrease = 0.1
        proposalA.pensionContribution = 101010101012223
        proposalA.dateCreated = NSDate()
        proposalA.wageClasses = nil
       
        
        adD.saveContext()
        
    }
    
    
}


