//
//  ViewController.swift
//  Animation
//
//  Created by Tejaswini on 14/03/18.
//  Copyright © 2018 Tejaswini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var counterView: CounterView!
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var graphView: GraphView!
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLabel.text = String(counterView.counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 @IBAction func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            counterView.counter += 1
        }
        else{
            counterView.counter -= 1
        }
        
        counterLabel.text = String(counterView.counter)
    
        if isGraphViewShowing {
            //counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(_ sender: UITapGestureRecognizer) {
        if isGraphViewShowing{
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }
        else{
             UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
}

