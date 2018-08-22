//
//  SaveViewController.swift
//  AudioMemo
//
//  Created by Selina Kröcker on 20.08.18.
//  Copyright © 2018 Selina Piper. All rights reserved.
//

import UIKit

class SaveViewController: UIViewController {

    
    //--------------------------------------------------
    // MARK: - IBOutlet
    //--------------------------------------------------
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var categoryButtons: [UIButton]!
    
    //--------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------
    
    var category = "Important"
    
    
    //--------------------------------------------------
    // MARK: - Lifecycle
    //--------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //--------------------------------------------------
    // MARK: - IBActions
    //--------------------------------------------------
    
    @IBAction func buttonHandler(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            switch title {
            case "Important","Today":
                updateCategory(for: title)
            case "Save":
                break
            case "Back":
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    //--------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------
    
    func  updateCategory(for title: String) {
        category = title
        for button in categoryButtons {
            if button.titleLabel?.text == title {
                button.setTitleColor(UIColor.red, for: .normal)
            } else {
                button.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
}
