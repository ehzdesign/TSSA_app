//
//  wizardQuestionsModel.swift
//  tssaScroll
//
//  Created by Erick Hernandez on 2016-03-15.
//  Copyright © 2016 Erick Hernandez. All rights reserved.
//

import Foundation
import UIKit

//some questions have an added comment or extra line of info for those that do not nil is implemented

struct wizardQuestionModel {
    let question : [[String?]] = [
        ["The next few steps will ensure your home is being kept safe from harmful CO gases.","click continue to begin setting up your home"],
        ["Select your CO environment"],
        ["Do you have a basement?"],
        ["Do you have a garage?"],
        ["How many floors do you have?","(not including basement)"],
        ["Every floor should be equipped with at least 1 CO and 1 smoke detector", "Did you know?", "dont worry we set all that up for you already!"],
        ["Add items to your floor"],
        ["Congratulations you are all set up!"]
        
    ]
    
    // bg colors for each view
    let bgColor : [UIColor] = [
        UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0), /* #da3d4f red */
        UIColor.whiteColor(),
        UIColor.whiteColor(),
        UIColor.whiteColor(),
        UIColor.whiteColor(),
        UIColor.whiteColor(),
        UIColor.whiteColor(),
        UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0), /* #da3d4f */
    ]
    
    
    //text color for the questions
    let textColor : [UIColor] = [
        UIColor.whiteColor(),
        UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1.0) /* #7a7a7a */,
        UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1.0) /* #7a7a7a */,
        UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1.0) /* #7a7a7a */,
        UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1.0) /* #7a7a7a */,
        UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1.0) /* #7a7a7a */,
        UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1.0) /* #7a7a7a */,
        UIColor.whiteColor()
        
        
    ]
    
    
    //upperText color for each question
    let upperTextColor : [UIColor?] = [
        nil,
        nil,
        nil,
        nil,
        nil,
        UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0), /*red*/
        nil,
        nil,
        ]
    
    
    //lower text color for each question
    let lowerTextColor : [UIColor?] = [
        UIColor.whiteColor(),
        nil,
        nil,
        nil,
        UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0), /*red*/
        UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0), /*red*/
        nil,
        nil
        
        
    ]
    
    
    
}