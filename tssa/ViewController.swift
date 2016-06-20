//
//  ViewController.swift
//  tssaScroll
//
//  Created by Erick Hernandez on 2016-03-10.
//  Copyright © 2016 Erick Hernandez. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIScrollViewDelegate, AKPickerViewDataSource, AKPickerViewDelegate {
    
    let homeSetupData = NSUserDefaults.standardUserDefaults()
    
    //screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    
    let buttonModel = buttons()
    
    
    @IBOutlet weak var continueButtonHeight: NSLayoutConstraint!
    
    
    
    //scroll view to hold wizard questions
    var wizardScrollView: UIScrollView! = UIScrollView()
    
    
    //var pageControl: UIPageControl! = UIPageControl()
    var pageControl : UIPageControl = UIPageControl()
    
   
    
    
    
    //create variable to access the wizard questions
    let wizardQuestion = wizardQuestionModel()
    
    
    @IBOutlet weak var wizardContinueButton: UIButton!
    
    
    // array of names to be given to every new view (wizard question)
    let wizardQuestionArray = ["wizardQuestionIntro", "wizardQuestionOne", "wizardQuestionTwo", "wizardQuestionThree", "wizardQuestionFour", "wizardQuestionFive", "wizardQuestionSix", "wizardQuestionSeven"]
    
    
    
    var wizardQuestionViewArray:[QuestionView] = [];
    
    var pageControlCounter = 1
    
    //variable for scroll selector for items using AKPickerVIew
    let pickerView = AKPickerView()
    
    //icons for picker view
    let itemIconsArray = ["stove_", "smoke_icon", "fire_place", "co_icon", "furnace_icon"]
    
    //text label for current item in picker view
    let currentPickerItemLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get screen dimensions
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        //add size and position of pageControl
        pageControl.frame = CGRectMake(0, 40, screenWidth, 20)
        
        
        //add pageControl to view
        self.view.addSubview(pageControl)
        
        print("does home have basement = \(homeSetupData.boolForKey("hasBasement"))")
        
        
        print("*****\(wizardScrollView.frame)")
        
        //styie for continue button
        wizardContinueButton.backgroundColor = UIColor.clearColor()
        wizardContinueButton.layer.cornerRadius = 25
        wizardContinueButton.layer.borderWidth = 1.5
        wizardContinueButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        //load the settings for the page control indicators (controls , dots, etc)
        configurePageControl()
        // Do any additional setup after loading the view, typically from a nib.
        
        wizardScrollView.delegate = self
        
        //animate bg color of view
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.backgroundColor = UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0) /* #da3d4f red */
        })
        
        
        //create size of scroll view
        self.wizardScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 140)
        
        //add scroll view to viewController
        self.view.addSubview(wizardScrollView)
        
        //get height of scroll view and store it
        //        let wizardScrollViewHeight = self.wizardScrollView.frame.height
        
        //get width of scroll view and store it
        let wizardScrollViewWidth = self.wizardScrollView.frame.width
        
        //store height of wizard question view based on scroll view height
        let wizardQuestionViewHeight = self.wizardScrollView.frame.height * 80/100
        
        
        
        //store width of wizard question view based on scroll view width
        let wizardQuestionViewWidth = self.wizardScrollView.frame.width - wizardScrollView.frame.width * 10/100
        
        
        
        
        //set content size based on width of wizard question view multiplied by amount of views created for each question. which are stored in wizardQuestionArray
        self.wizardScrollView.contentSize = CGSizeMake(self.wizardScrollView.frame.width*CGFloat(wizardQuestionArray.count), self.wizardScrollView.frame.height)
        
        // set paging on scroll view
        self.wizardScrollView.pagingEnabled = true
        
        //hide scroll bar at bottom of scroll view
        self.wizardScrollView.showsHorizontalScrollIndicator = false
        
        //todo: ***** ask greg ****
        self.pageControl.addTarget(self, action: #selector(ViewController.changePage(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
        //add delegates for item selector using AKPickerView
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
        self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
        self.pickerView.pickerViewStyle = .Wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        
        
        
        
        // create a loop to initialize all views onto the view controller
        for (index, element) in wizardQuestionArray.enumerate() {
            print("Item \(index): \(element)")
            
            //create each view for question in wizardQuestionScreenArray
            let element = QuestionView(frame: CGRectMake(wizardScrollViewWidth*CGFloat(index) + wizardScrollView.frame.width * 5/100, 80, wizardQuestionViewWidth,wizardQuestionViewHeight))
            
            
            
            //set bgColor for wizardQuestionView in scroll view
            element.backgroundColor = wizardQuestion.bgColor[index]
            
            //add wizardQuestionView to scroll view
            self.wizardScrollView.addSubview(element)
            
            //add basement choice
            
            
            //add yes no buttons to screens 3 and 4
            if(index == 2 || index == 3) {
                
                //use this to add yes button
                createYesNoButtonWithLabel(element , type: "yes")
                
                //use this to add no button
                createYesNoButtonWithLabel(element , type: "no")
                
                
            }
            
            if(index == 5){
                
                element.addSubview(element.wizardImage)
                
            }
            
            
            if(index == 6){
                //setup scroll indicator to add items to floor
                
                element.addSubview(pickerView)
                pickerView.frame = CGRectMake(0, 200, screenWidth, 100)
                
                //add text label for current item in picker view to wizard screen
//                currentPickerItemLabel.translatesAutoresizingMaskIntoConstraints = false
                element.addSubview(currentPickerItemLabel)
                currentPickerItemLabel.frame = CGRectMake(0, 300, screenWidth, 30)
                currentPickerItemLabel.textAlignment = .Center

                
                
                
//                let topConstraint = NSLayoutConstraint(
//                    item: currentPickerItemLabel,
//                    attribute: NSLayoutAttribute.TopMargin,
//                    relatedBy: NSLayoutRelation.Equal,
//                    toItem: self.pickerView,
//                    attribute: NSLayoutAttribute.BottomMargin,
//                    multiplier: 1,
//                    constant: 31)
//                
//                NSLayoutConstraint.activateConstraints([topConstraint])

                
            }
            
            
            
            
            
            //set size and position of question label
            //             self.questionLabel.frame = CGRectMake(15, 80, self.frame.width - 30, 100)
            
            //get question and append to question label
            element.questionLabel.text = wizardQuestion.question[index][0]
            
            //modify the text color based on current view (i.e. index)
            element.questionLabel.textColor = wizardQuestion.textColor[index]
            
            //get appropriate text from questions to append to bottom info label and top label
            if (wizardQuestion.question[index].count == 2) {
                element.addSubview(element.additionalInfoBottomLabel)
                element.additionalInfoBottomLabel.text = wizardQuestion.question[index][1]
                element.additionalInfoBottomLabel.textColor = wizardQuestion.lowerTextColor[index]
                
                
                
                
            }
            else if (wizardQuestion.question[index].count == 3) {
                
                //***uncomment bottom line to add top label "did you know?" back to view
                
                //element.addSubview(element.additionalInfoTopLabel)
                element.addSubview(element.additionalInfoBottomLabel)
              
                
                element.additionalInfoTopLabel.text = wizardQuestion.question[index][1]
                element.additionalInfoTopLabel.textColor = wizardQuestion.upperTextColor[index]
                element.additionalInfoBottomLabel.text = wizardQuestion.question[index][2]
                element.additionalInfoBottomLabel.textColor = wizardQuestion.lowerTextColor[index]
                
            }
            
            wizardQuestionViewArray.append(element)
            
        }
        
        
    }
    
    
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available views we have stored in wizardQuestion Array.
        
        self.pageControl.numberOfPages = wizardQuestionArray.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.redColor()
        
        //change color of indicator dots
        self.pageControl.pageIndicatorTintColor = UIColor(hue: 0.0111, saturation: 0, brightness: 0.92, alpha: 1.0) /* #eaeaea */
        
        //change color of current page indicator dot
        self.pageControl.currentPageIndicatorTintColor = UIColor(hue: 0, saturation: 0, brightness: 0.81, alpha: 1.0) /* #d1d1d1 */
        
        //add page control to view controller
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * self.wizardScrollView.frame.size.width
        self.wizardScrollView.setContentOffset(CGPointMake(x, 0), animated: true)
        //        print("changePage")
        
        animateTextOnNewPage()
        changeViewControllerBGColor()
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        //        print("swipe page")
        
        animateTextOnNewPage()
        changeViewControllerBGColor()
        
    }
    
    
    //    func printFonts() {
    //        let fontFamilyNames = UIFont.familyNames()
    //        for familyName in fontFamilyNames {
    //            print("------------------------------")
    //            print("Font Family Name = [\(familyName)]")
    //            let names = UIFont.fontNamesForFamilyName(familyName)
    //            print("Font Names = [\(names)]")
    //        }
    //    }
    
    
    
    func animateTextOnNewPage (){
        for (_, element) in wizardQuestionViewArray.enumerate(){
            
            if (pageControl.currentPage == wizardQuestionViewArray.indexOf(element)){
                
                print(element.questionLabel.text)
                element.questionLabel.animation = "pop"
                element.questionLabel.duration = 1
                element.questionLabel.animate()
            }
            
        }
    }
    
    func changeViewControllerBGColor(){
        for (_, _) in wizardQuestionViewArray.enumerate(){
            
            if (pageControl.currentPage == 0 || pageControl.currentPage == wizardQuestionViewArray.count - 1){
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.view.backgroundColor = UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0) /* #da3d4f red */
                    self.wizardContinueButton.backgroundColor = UIColor.clearColor()
                    self.wizardContinueButton.layer.borderColor = UIColor.whiteColor().CGColor
                    self.wizardContinueButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                })
                
            }else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.view.backgroundColor = UIColor.whiteColor()
                    self.wizardContinueButton.backgroundColor = UIColor.clearColor()
                    self.wizardContinueButton.layer.borderColor = UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0) /* #da3d4f red */.CGColor
                    self.wizardContinueButton.setTitleColor(UIColor(hue: 0.9833, saturation: 0.72, brightness: 0.85, alpha: 1.0) /* #da3d4f red */, forState: .Normal)
                    
                })
                
                
            }
            
            
        }
        
        
        
    }
    
    
    @IBAction func continueButtonTapped(sender: AnyObject) {
        changePage()
    }
    
    func changePage() {
        pageControl.currentPage += 1
        let x = CGFloat(pageControl.currentPage) * self.wizardScrollView.frame.size.width
        self.wizardScrollView.setContentOffset(CGPointMake(x, 0), animated: true)
        
        changeViewControllerBGColor()
        animateTextOnNewPage()
    }
    
    
    // create YES and NO buttons with labels
    func createYesNoButtonWithLabel (view: UIView , type: String) {
        let button = SpringButton();
        let buttonLabel = UILabel();
        
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        let buttonSize = screenWidth / 6
        //create no button if value pased is equal to "no"
        if(type == "no"){
            if let image = UIImage(named: "no_btn") {
                button.setImage(image, forState: .Normal)
                buttonLabel.text = "no"
                
                button.frame = CGRectMake(screenWidth/2 + buttonSize - 10, screenHeight -  buttonSize * 3, buttonSize, buttonSize)
                let buttonOriginX = button.frame.origin.x
                let buttonOriginY = button.frame.origin.y
                buttonLabel.frame = CGRectMake(buttonOriginX - buttonSize/2 + 8, buttonOriginY + buttonSize, buttonSize + buttonSize - 10, buttonSize + 10)
                button.addTarget(self, action: #selector(ViewController.noButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                
                
            }
        }else if (type == "yes"){
            if let image = UIImage(named: "yes_btn") {
                button.setImage(image, forState: .Normal)
            }
            
            button.frame = CGRectMake(screenWidth/2 - buttonSize*2 - 10, screenHeight - buttonSize * 3, buttonSize, buttonSize)
            
            
            button.addTarget(self, action: #selector(ViewController.yesButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            //button size is 70 x 70
            
            let buttonOriginX = button.frame.origin.x
            let buttonOriginY = button.frame.origin.y
            buttonLabel.frame = CGRectMake(buttonOriginX - buttonSize/2, buttonOriginY + buttonSize, buttonSize + buttonSize - 10, buttonSize + 10)
            buttonLabel.text = "yes"
            
            
        }
        
        
        let fontSize = buttonLabel.font.pointSize;
        
        buttonLabel.textAlignment = .Center
        buttonLabel.font = UIFont(name: "Futura", size: fontSize)
        buttonLabel.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1.0) /* #7a7a7a */
        
        //add button and label to parent view
        view.addSubview(button)
        view.addSubview(buttonLabel)
        
        
    }
    
    //this is the function when the yes button is clicked
    
    func yesButtonPressed(sender: SpringButton){
        if (pageControl.currentPage == 2 /*has basement question*/){
            print("has basement == true")
            //set that user has basement  = true
            homeSetupData.setBool(true, forKey: "hasBasement")
        }else if (pageControl.currentPage == 3 /*has garage question*/){
            print("has garage == true")
            //set that user has garage  = true
            homeSetupData.setBool(true, forKey: "hasGarage")
        }
        
        //animate button when clicked
        sender.animation = "pop"
        sender.duration = 1
        sender.animate()
        
        //delay the changing  of page to allow for button animation
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(ViewController.changePage as (ViewController) -> () -> ()), userInfo: nil, repeats: false)
        
        
    }
    
    //    this is the buton when the no button is clicked
    
    func noButtonPressed(sender: SpringButton){
        print("no button pressed")
        if (pageControl.currentPage == 2 /*has basement question*/){
            //set that user has basement  = false
            print("has basement == false")
            homeSetupData.setBool(false, forKey: "hasBasement")
            
        }else if (pageControl.currentPage == 3 /*has garage question*/){
            print("has garage == false")
            //set that user has garage  = false
            homeSetupData.setBool(false, forKey: "hasGarage")
        }
        
        //aanimate button when clicked
        sender.animation = "pop"
        sender.duration = 1
        sender.animate()
        
        //delay the changing  of page to allow for button animation
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(ViewController.changePage as (ViewController) -> () -> ()), userInfo: nil, repeats: false)
        
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return self.itemIconsArray.count
    }
    
//    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
//        return self.newNames[item]
//    }
    
    func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.itemIconsArray[item])!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        print("current icon \(self.itemIconsArray[item])")
        currentPickerItemLabel.text = itemIconsArray[item]
        
        
        
    }
    
    

    
    
    
    
    
    
}






