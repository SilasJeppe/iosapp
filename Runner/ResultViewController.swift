//
//  ResultViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 26/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITextFieldDelegate {
    var resultActivity = Activity(newId: 0)
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!

    @IBOutlet var activityNameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assign our selves as text field delegate
        activityNameTextField.delegate = self
        descriptionTextField.delegate = self
        
        distanceLabel.text = String(resultActivity.distance)
        print(resultActivity)
    }
    @IBAction func saveButtonPressed(sender: AnyObject) {
        print("debug")
    }
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}