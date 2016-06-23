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
    
    //to store home sections for home setup data
    var homeSectionsArray:[String] = ["first floor"]
    

    //screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    
    let buttonModel = buttons()
    
    
    @IBOutlet weak var continueButtonHeight: NSLayoutConstraint!
    
    
    
    //scroll view to hold wizard questions
    var wizardScrollView: UIScrollView! = UIScrollView()
    
    
    //var pageControl: UIPageControl! = UIPageControl()
    var pageControl : UIPageControl = UIPageControl()
    
   //currently selected item to be added to floor
    var justSelected = ""
    
    
    //create variable to access the wizard questions
    let wizardQuestion = wizardQuestionModel()
    
    
    @IBOutlet weak var wizardContinueButton: UIButton!
    
    
    // array of names to be given to every new view (wizard question)
    let wizardQuestionArray = ["wizardQuestionIntro", "wizardQuestionOne", "wizardQuestionTwo", "wizardQuestionThree", "wizardQuestionFour", "wizardQuestionFive", "wizardQuestionSix", "wizardQuestionSeven"]
    
    
    
    var wizardQuestionViewArray:[QuestionView] = [];
    
    var pageControlCounter = 1
    
    //variable for scroll selector for items using AKPickerVIew
    let pickerView = AKPickerView()
    
    //variable for scroll selector for stories using AKPickerVIew
    let storiesPickerView = AKPickerView()
    
    //icons for picker view
    let itemIconsArray = ["stove_", "smoke_icon", "fire_place", "co_icon", "furnace_icon"]
    
    //data for picker view
    let storiesDataArray = ["1", "2", "3"]

    
    //text label for current item in picker view
    let currentPickerItemLabel = UILabel()
    
    
    //buttons for selected stories
    var stories1 = SpringButton()
    var stories2 = SpringButton()
    var stories3 = SpringButton()
    
    //store default how many stories in home
    var numberOfStories:String = "1"
    
    
    let downStepperBtn = SpringButton()
    let upStepperBtn = SpringButton()
    
    var floorChoiceLabel = UILabel()
    
    var addItemToFloorBtn = SpringButton()
    
    
   
    var floorCounter = 0
 
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("home data: \(homeSetupData.dictionaryRepresentation())")
       
        //test print sections of home
//        print("104: these are the sections of the \(homeSetupData.objectForKey("HomeSections"))")
        
        //get screen dimensions
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        //add size and position of pageControl
        pageControl.frame = CGRectMake(0, 40, screenWidth, 20)
        
        
        //add pageControl to view
        self.view.addSubview(pageControl)
        
//        print("does home have basement = \(homeSetupData.boolForKey("hasBasement"))")
        
        
//        print("*****\(wizardScrollView.frame)")
        
        //styie for continue button
        wizardContinueButton.backgroundColor = UIColor.clearColor()
        wizardContinueButton.layer.cornerRadius = 22
        wizardContinueButton.layer.borderWidth = 1.5
        wizardContinueButton.layer.borderColor = UIColor.whiteColor().CGColor
        wizardContinueButton.titleLabel!.font =  UIFont(name: "Futura-Medium", size: 18)
        
        
        
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
//            print("Item \(index): \(element)")
            
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
            
            if(index == 4){
                
                
                
                let storieBtnArray = [stories1, stories2, stories3]
                
               stories1.layer.borderColor = UIColor.redColor().CGColor
               stories1.layer.borderWidth = 1
                
                
                for btn in storieBtnArray {
                    
                    
                    element.addSubview(btn)
                    btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    btn.backgroundColor = UIColor.clearColor()
                    btn.layer.cornerRadius = 25
                    
                    
                    btn.addTarget(self, action: #selector(ViewController.storieBtnClicked(_:)), forControlEvents: .TouchUpInside)

                }
                
                self.stories1.frame = CGRectMake(wizardQuestionViewWidth/2 - 100, 260, 51, 51)
                self.stories1.setTitle("1", forState: .Normal)
                self.stories2.frame = CGRectMake(wizardQuestionViewWidth/2 - 25, 260, 51, 51)
                self.stories2.setTitle("2", forState: .Normal)
                self.stories3.frame = CGRectMake(wizardQuestionViewWidth/2 + 50, 260, 51, 51)
                self.stories3.setTitle("3", forState: .Normal)
                
                
                
            }

            
            if(index == 5){
                
                element.addSubview(element.wizardImage)
                
            }
            
            
            if(index == 6){
                
                
                //setup scroll indicator to add items to floor
                element.addSubview(pickerView)
                pickerView.frame = CGRectMake(0, 200, wizardQuestionViewWidth, 100)
                
                //add text label for current item in picker view to wizard screen
                //                currentPickerItemLabel.translatesAutoresizingMaskIntoConstraints = false
                element.addSubview(currentPickerItemLabel)
                currentPickerItemLabel.frame = CGRectMake(0, 300, wizardQuestionViewWidth, 30)
                currentPickerItemLabel.textAlignment = .Center
                
                //initialize label with name of first icon on load
                currentPickerItemLabel.text = itemIconsArray[0]
                //create buttons for selecting current floor to add items to
              
                
                let stepperBtnArray = [downStepperBtn, upStepperBtn]
                
                //add function for click event on both stepper buttons
                for stepperBtn in stepperBtnArray {
                    stepperBtn.addTarget(self, action: #selector(ViewController.stepperBtnClicked(_:)), forControlEvents: .TouchUpInside)
//                    stepperBtn.backgroundColor = UIColor.blackColor()
                    stepperBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
                    stepperBtn.translatesAutoresizingMaskIntoConstraints = false
                    element.addSubview(stepperBtn)
                    
                }
                
//                downStepperBtn.setTitle("<", forState: .Normal)
//                upStepperBtn.setTitle(">", forState: .Normal)
                
                if let prevArrowImage = UIImage(named: "prev_arrow_icon") {
                    downStepperBtn.setImage(prevArrowImage, forState: .Normal)

                }
                
                if let nextArrowImage = UIImage(named: "next_arrow_icon") {
                    upStepperBtn.setImage(nextArrowImage, forState: .Normal)
                }
                
                
                
                
                //create label for floors
//                var floorChoiceLabel = UILabel()
//                floorChoiceLabel.frame = CGRectMake(wizardQuestionViewWidth/2 - 50, 150, 100, 50)
                floorChoiceLabel.textAlignment = .Center
                floorChoiceLabel.text = homeSectionsArray[0]
                
                floorChoiceLabel.translatesAutoresizingMaskIntoConstraints = false
                
                //add to question view
                element.addSubview(floorChoiceLabel)
                
                //add item to floor button to superview
                addItemToFloorBtn.backgroundColor = UIColor.redColor()
                addItemToFloorBtn.layer.cornerRadius = 30
                
                element.addSubview(addItemToFloorBtn)
                
                addItemToFloorBtn.frame = CGRectMake(wizardQuestionViewWidth/2 - 30, 400, 60, 60)
                
                 addItemToFloorBtn.addTarget(self, action: #selector(ViewController.addItemToFloorAnimate(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                
               
                //VFL layout for floor selector
                let floorChoiceViews = ["floorDown": downStepperBtn, "floorLabel": floorChoiceLabel, "floorUp": upStepperBtn, "pickerView" : pickerView, "addItemBtn": addItemToFloorBtn, "sv": view ]
                
                
                var allFloorChoiceConstraints = [NSLayoutConstraint]()
                
                
//                setup horizontal constraint for < floor > selector
                
                let floorChoiceRowHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
                    "H:|-90-[floorDown(30)]-[floorLabel(>=100)]-[floorUp(30)]",
    
                    options: [.AlignAllCenterY],
                    metrics: nil,
                    views: floorChoiceViews)
                allFloorChoiceConstraints += floorChoiceRowHorizontalConstraints
                
                //vertical constraint for floorDown button
                
                let floorDownVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
                    "V:[floorDown(30)]-10-[pickerView]",
                     options: [],
                     metrics: nil,
                     views: floorChoiceViews)
                allFloorChoiceConstraints += floorDownVerticalConstraint
                
                //vertical constraint for floorLabel button
                
                let floorLabelVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
                    "V:[floorLabel(50)]-10-[pickerView]",
                    options: [],
                    metrics: nil,
                    views: floorChoiceViews)
                allFloorChoiceConstraints += floorLabelVerticalConstraint
                
                //vertical constraint for floorLabel button
                
                let floorUpVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
                    "V:[floorUp(30)]-10-[pickerView]",
                    options: [],
                    metrics: nil,
                    views: floorChoiceViews)
                allFloorChoiceConstraints += floorUpVerticalConstraint
                
                
                
                
                NSLayoutConstraint.activateConstraints(allFloorChoiceConstraints)
                
                
                
//                //setup scroll indicator to add items to floor
//                element.addSubview(pickerView)
//                pickerView.frame = CGRectMake(0, 200, wizardQuestionViewWidth, 100)
//                
//                //add text label for current item in picker view to wizard screen
////                currentPickerItemLabel.translatesAutoresizingMaskIntoConstraints = false
//                element.addSubview(currentPickerItemLabel)
//                currentPickerItemLabel.frame = CGRectMake(0, 300, wizardQuestionViewWidth, 30)
//                currentPickerItemLabel.textAlignment = .Center
//                
//                //initialize label with name of first icon on load
//                currentPickerItemLabel.text = itemIconsArray[0]
                
                
                
                
                
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
                
//                print(element.questionLabel.text)
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
            //add basement to homeSectionsArray if does not exist
            if !self.homeSectionsArray.contains("basement"){
                homeSectionsArray.append("basement")
                homeSetupData.setObject(homeSectionsArray, forKey: "homeSections")
            }
//            print("463: this is the sections of the home\(homeSetupData.objectForKey("HomeSections"))")

        }else if (pageControl.currentPage == 3 /*has garage question*/){
            print("has garage == true")
            //set that user has garage  = true
            homeSetupData.setBool(true, forKey: "hasGarage")
            //add basement to homeSectionsArray if does not exist
            if !self.homeSectionsArray.contains("garage"){
                homeSectionsArray.append("garage")
                homeSetupData.setObject(homeSectionsArray, forKey: "homeSections")
            }
//            print("473: this is the sections of the home\(homeSetupData.objectForKey("HomeSections"))")

        }
        
        //animate button when clicked
        sender.animation = "pop"
        sender.duration = 1
        sender.animate()
        
        //delay the changing  of page to allow for button animation
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(ViewController.changePage as (ViewController) -> () -> ()), userInfo: nil, repeats: false)
        
        
    }
    
    //    this is the function when the no button is clicked
    
    func noButtonPressed(sender: SpringButton){
        //check if garage exists in homeSectionsArray
//        print("no button pressed")
        if (pageControl.currentPage == 2 /*has basement question*/){
            //set that user has basement  = false
//            print("has basement == false")
            homeSetupData.setBool(false, forKey: "hasBasement")
            //remove basement if exists from array of home sections and from homeSetupData
            if self.homeSectionsArray.contains("basement"){
                homeSectionsArray = homeSectionsArray.filter{$0 != "basement"}
                homeSetupData.setObject(homeSectionsArray, forKey: "homeSections")
            }
//            print("496 : this is the sections of the home\(homeSetupData.objectForKey("HomeSections"))")

            
            
        }else if (pageControl.currentPage == 3 /*has garage question*/){
//            print("has garage == false")
            //set that user has garage  = false
            homeSetupData.setBool(false, forKey: "hasGarage")
         
            //remove garage if exists from array of home sections and from homeSetupData
            if self.homeSectionsArray.contains("garage"){
                homeSectionsArray = homeSectionsArray.filter{$0 != "garage"}
                homeSetupData.setObject(homeSectionsArray, forKey: "homeSections")
            }
         
//            print("518 : this is the sections of the home\(homeSetupData.objectForKey("HomeSections"))")
            
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
//        print("current icon \(AKPickerView.collectionView?.cell)")
       

        currentPickerItemLabel.text = itemIconsArray[item]
        addItemToFloor( itemIconsArray[item])
        
        
    }
    
    func addItemToFloor(itemToAdd:String){
        justSelected = itemToAdd
//        print("573: \(justSelected)")
    }
    
    
    // MARK: select how many stories home has button clicked function
    func storieBtnClicked(sender: UIButton) {
        sender.layer.borderColor = UIColor.redColor().CGColor
        sender.layer.borderWidth = 1
        if(sender === stories1){
            numberOfStories = "1"
            
            homeSectionsArray = homeSectionsArray.filter(){$0 != "second floor"}
            homeSectionsArray = homeSectionsArray.filter(){$0 != "third floor"}
            homeSetupData.setObject(homeSectionsArray, forKey: "homeSections")
            stories2.layer.borderColor = UIColor.clearColor().CGColor
            stories3.layer.borderColor = UIColor.clearColor().CGColor
            
        }
        if(sender === stories2){
            numberOfStories = "2"
//           check if second and third floor exists
            homeSectionsArray = homeSectionsArray.filter(){$0 != "second floor"}
            homeSectionsArray = homeSectionsArray.filter(){$0 != "third floor"}
            
//            add second floor to home sections array
            homeSectionsArray.append("second floor")
             homeSetupData.setObject(homeSectionsArray, forKey: "homeSections")
            stories1.layer.borderColor = UIColor.clearColor().CGColor
            stories3.layer.borderColor = UIColor.clearColor().CGColor
        }
        if(sender === stories3){
           numberOfStories = "3"
            
            homeSectionsArray = homeSectionsArray.filter(){$0 != "second floor"}
            homeSectionsArray = homeSectionsArray.filter(){$0 != "third floor"}
            
            homeSectionsArray.append("second floor")
            homeSectionsArray.append("third floor")
             homeSetupData.setObject(homeSectionsArray, forKey: "homeSections")
            stories1.layer.borderColor = UIColor.clearColor().CGColor
            stories2.layer.borderColor = UIColor.clearColor().CGColor
        }
    
    }
    
    
    //function for stepper button clicked for selecting floor where items are added
    func stepperBtnClicked(sender: UIButton){
        
        var homeSections = homeSetupData.arrayForKey("homeSections")
        
        if(sender == downStepperBtn ) {
        //move down through home sections Array
        floorCounter-=1
            if(floorCounter < 0){
//                floorCounter = homeSectionsArray.count - 1
                 floorCounter = homeSetupData.valueForKey("homeSections")!.count - 1
            }
        floorChoiceLabel.text = homeSections![floorCounter] as! String
        }
        else if(sender == upStepperBtn) {
        //move up through home sections Array
        floorCounter+=1
            if(floorCounter > homeSetupData.valueForKey("homeSections")!.count - 1){
                floorCounter = 0
            }
        floorChoiceLabel.text = homeSections![floorCounter] as! String
        }
    }
    
    
    
    //add item to floor animation
    
    func addItemToFloorAnimate(sender: AnyObject){
      addItemToFloorBtn.transform = CGAffineTransformMakeScale(5.0, 1.0)
        addItemToFloorBtn.layer.cornerRadius = 3
    }

    
   
    
    
    
    
}






