//
//  ViewController.swift
//  Test
//
//  Created by Savannah McCoy on 7/17/16.
//  Copyright © 2016 Savannah McCoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        buttonButton.imageView?.image = UIImage(named: "redCircle" )
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

