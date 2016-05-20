//
//  buttons.swift
//  tssaScroll
//
//  Created by Erick Hernandez on 2016-03-17.
//  Copyright © 2016 Erick Hernandez. All rights reserved.
//

import Foundation
import UIKit

struct buttons {
    
    func createYesButton (view: UIView) {
        let button = UIButton();
        button.setTitle("Add", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.frame = CGRectMake(15, -50, 200, 100)
        view.addSubview(button)
    }
    
    func createNoButton (view: UIView) {
        let button = UIButton();
        button.setTitle("No", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.frame = CGRectMake(15, -50, 200, 100)
        view.addSubview(button)
    }
    
}