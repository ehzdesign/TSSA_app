//
//  QuestionView.swift
//  tssaScroll
//
//  Created by Erick Hernandez on 2016-03-15.
//  Copyright © 2016 Erick Hernandez. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    //create question label to store question for each view
    //    var questionLabel = UILabel()
    
    var questionLabel = SpringLabel()
    
    //create top label for additional information if view requires
    var additionalInfoTopLabel = UILabel()
    
    //create bottom label for additional information if view requires
    var additionalInfoBottomLabel = UILabel()
    
    //create image for wizard view (*screen 6 only )
    
    //    var wizardImage = SpringImageView()
    let wizardImage = SpringImageView()
    
    //access wizard questions
    var wizardQuestion = wizardQuestionModel()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //get height and width of questionView frame
        let questionViewHeight = self.frame.height
        let questionViewWidth = self.frame.width
        
        
        
        
        //add shadow to question view
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowRadius = 10
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
        
        //       self.layer.shouldRasterize = true
        
        //add rounded edge on view
        self.layer.cornerRadius = 10
        
        //add question label to each view
        self.addSubview(questionLabel)
        
        
        questionLabel.animation = "pop"
        questionLabel.duration = 1
        questionLabel.animate()
        
        
        
        //set size of question label and placement
        //as well as text attributes
        self.questionLabel.frame = CGRectMake(questionViewWidth * 4/100, questionViewHeight * 3/100, questionViewWidth - questionViewWidth * 8/100, questionViewHeight * 40/100)
        self.questionLabel.lineBreakMode = .ByWordWrapping
        self.questionLabel.numberOfLines = 5
        self.questionLabel.textAlignment = .Center
        
        let originYQuestionLabel = self.questionLabel.frame.origin.y
        
        let fontSize = self.questionLabel.font.pointSize;
        self.questionLabel.font = UIFont(name: "Futura-Medium", size: 20)
        
        
        //set size of top label and placement
        //as well as text attributes
        self.additionalInfoTopLabel.frame = CGRectMake(15, originYQuestionLabel - 60, self.frame.width - 30, 60)
        self.additionalInfoTopLabel.numberOfLines = 1
        self.additionalInfoTopLabel.textAlignment = .Center
        self.additionalInfoTopLabel.font = UIFont(name: "Futura", size: fontSize - 3)
        
        
        //set size of bottom label and placement
        //as well as text attributes
        self.additionalInfoBottomLabel.numberOfLines = 3
        self.additionalInfoBottomLabel.textAlignment = .Center
        self.additionalInfoBottomLabel.font = UIFont(name: "Futura", size: fontSize - 3)
        
        self.additionalInfoBottomLabel.frame = CGRectMake(15, originYQuestionLabel + 100, self.frame.width - 30, 60)
        
        
        //create wizard question image
        let image: UIImage = UIImage(named: "wizard6_Img")!
        wizardImage.frame = CGRectMake(self.frame.width/2 - 60, self.frame.height - 130, 120, 120)
        wizardImage.contentMode = .ScaleAspectFit
        wizardImage.image = image
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
