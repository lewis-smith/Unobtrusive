//
//  DetailViewController.swift
//  UnobtrusivePrompt
//
//  Created by Lewis Smith on 18/01/2017.
//  Copyright © 2017 Lewis Makes Apps. All rights reserved.
//

import UIKit
import Unobtrusive

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    @IBOutlet weak var unobtrusiveView: UnobtrusiveView!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
        
        if let promptView = self.unobtrusiveView {
            if self.view.tag == 1 {
                promptView.setLabelText(text: "short text")
            }
            if self.view.tag == 2 {
                // do not set label text
            }
            if self.view.tag == 3 {
                promptView.setLabelText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            }
            
            promptView.tapGoCallback = {
                print("\(self.view.tag)")
            }
            
            promptView.tapCloseCallback = {
                print("closed")
            }
            
            promptView.label.font = 
            promptView.button.backgroundColor = UIColor.blue
            promptView.button.setTitleColor(UIColor.white, for: .normal)
            promptView.backgroundColor = UIColor.gray
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

