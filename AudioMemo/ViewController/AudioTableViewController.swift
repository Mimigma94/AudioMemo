//
//  ViewController.swift
//  AudioMemo
//
//  Created by Selina Kröcker on 16.08.18.
//  Copyright © 2018 Selina Piper. All rights reserved.
//

import UIKit

class AudioTableViewController: UIViewController {

    //--------------------------------------------------
    // MARK: - IBOutlets
    //--------------------------------------------------
    
    @IBOutlet weak var zeroHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fullHeightConstraint: NSLayoutConstraint!
    
    //--------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------
    
    var playerShown = false
    
    //--------------------------------------------------
    // MARK: - Lifecycle
    //--------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(animatePlayer), userInfo: nil, repeats: true)
    }
    
    //--------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------
    
    @objc func animatePlayer() {
    playerShown = !playerShown
        
        if playerShown {
            zeroHeightConstraint.isActive = false
            fullHeightConstraint.isActive = true
        } else {
            fullHeightConstraint.isActive = false
            zeroHeightConstraint.isActive = true
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

