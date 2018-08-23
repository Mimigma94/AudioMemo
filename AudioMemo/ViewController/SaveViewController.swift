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
        nameTextField.delegate = self
    }
    
    //--------------------------------------------------
    // MARK: - IBActions
    //--------------------------------------------------
    
    @IBAction func buttonHandler(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            switch title {
            case "Important","Today":
                updateCategory(for: title)
            case "SAVE":
                saveNewFile()
            case "BACK":
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
    
    func saveNewFile() {
        if let name = nameTextField.text {
            // wenn da etwas steht und der name somit NICHT leer ist...mache das ->
            guard !name.isEmpty else {
                showAlert(reason: 0)
                return
            }
            
            let filename = name + ".caf"
            guard Utility.moveAudioFile(to: category, with: filename) else {
                showAlert(reason: 1)
                return
            }
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlert(reason: Int) {
        let message = reason == 0 ? "Please enter a name first!" : "The file could not be saved. Did you maybe choose a dublicate name?"
        // 1. UIAlertController erzeugen
        let alertViewController = UIAlertController(title: "Could not save file", message: message, preferredStyle: .alert)
        // 2. UIAlertAction erzeugen
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        // 3. Action zum AlertController hinzufügen
        alertViewController.addAction(okAction)
        // 4. mit present AlertController anzeigen
        present(alertViewController, animated: true, completion: nil)
    }
}

extension SaveViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
