//
//  ViewController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/23/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    
        var object = PFObject(className: "TestClass")
        object.addObject("Banana", forKey: "favoriteFood")
        object.addObject("Chocolate", forKey: "favoriteIceCream")
        object.save()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        
        
    }
    
}

