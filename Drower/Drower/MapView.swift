//
//  File.swift
//  Drower
//
//  Created by Gaurav on 8/12/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

import Foundation
import UIKit

class MapView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnOpenDrower(sender: UIButton)
    {
        AppDelegate.sharedInstance().OpenOrCloseDrower()
    }
}