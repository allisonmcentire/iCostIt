//
//  KGHighLightedButtonViewController.swift
//  iCostIt
//
//  Created by Allison Mcentire on 3/18/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import UIKit





class TutorialViewController: UIViewController {

    @IBOutlet weak var beginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginButton.layer.cornerRadius = 25
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
