//
//  PeekedViewController.swift
//  PreviewOrder
//
//  Created by Daniel Höpfl on 29.09.15.
//  Copyright © 2015 Daniel Höpfl. All rights reserved.
//

import UIKit

/// A view controller to be shown by the peek&pop mechanism
class PeekedViewController : UIViewController {

    /// Just a counter to show the number of calls to previewActionItems()
    var nr : Int = 0

    /// Closes the peeked view controller
    @IBAction func dismissMe() {
        dismissViewControllerAnimated(true, completion: nil);
    }

    /// That's what we want to check
    override func previewActionItems() -> [UIPreviewActionItem] {
        print ("previewActionItems() called")

        let callNr = ++nr
        let actionItem = UIPreviewAction(title: "Call #\(callNr)",
            style: .Default) { (_, _) -> Void in
                print("Action #\(callNr) tapped")
        }

        return [actionItem]
    }
}
