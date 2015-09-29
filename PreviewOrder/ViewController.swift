//
//  ViewController.swift
//  PreviewOrder
//
//  Created by Daniel Höpfl on 29.09.15.
//  Copyright © 2015 Daniel Höpfl. All rights reserved.
//

import UIKit

/// Example view controller that handles view controller previewing.
class ViewController: UIViewController, UIViewControllerPreviewingDelegate {

    /// Just a counter to show the number of calls to previewActionItems()
    var nr : Int = 0

    /// The previewing context while registerd for previewing
    weak var previewingContext : UIViewControllerPreviewing?

    /// Register for previewing
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if self.traitCollection.forceTouchCapability == .Available {
            self.previewingContext = self.registerForPreviewingWithDelegate(self, sourceView: self.view)
        }
    }

    /// Unregister from previewing (not needed)
    override func viewWillDisappear(animated: Bool) {
        if let previewingContext = self.previewingContext {
            self.unregisterForPreviewingWithContext(previewingContext)
        }

        super.viewWillDisappear(animated)
    }

    /// In case the trait collection changes, register for previewing
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        if self.previewingContext == nil && self.traitCollection.forceTouchCapability == .Available {
            self.previewingContext = self.registerForPreviewingWithDelegate(self, sourceView: self.view)
        }

        // Not needed (but does not hurt):
        if self.traitCollection.forceTouchCapability != .Available {
            if let previewingContext = self.previewingContext {
                self.unregisterForPreviewingWithContext(previewingContext)
            }
        }

        super.traitCollectionDidChange(previousTraitCollection)
    }

    /// The user wants to peek
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        print ("previewingContext(viewControllerForLocation:) called")
        return self.storyboard?.instantiateViewControllerWithIdentifier("peekedViewController")
    }

    /// The user pressed deeper
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        print ("previewingContext(commitViewController:) called")
        showViewController(viewControllerToCommit, sender: self)
    }

    /// That's what we want to check
    override func previewActionItems() -> [UIPreviewActionItem] {
        print ("previewActionItems() called")

        let actionItem = UIPreviewAction(title: "Call #\(++nr)",
            style: .Default) { (_, _) -> Void in
                print("Action tapped")
        }

        return [actionItem]
    }
}
