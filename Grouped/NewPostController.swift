//
//  NewPostController.swift
//  Grouped
//
//  Copyright (c) 2014 Grouped. All rights reserved.
//

import UIKit

class NewPostController: UIViewController {
	
	@IBOutlet weak var postField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    @IBAction func sendPost(AnyObject) {
        var message = PFObject(className:"Message")
		message["user"] = PFUser.currentUser().username
		message["group"] = group?.name
		message["message"] = postField.text
		message.save()
		var naviViews = self.navigationController!.viewControllers
		for var i = naviViews.count - 1; i > 0; --i {
			if (naviViews[i] as NSObject == self) {
				var theFeed = naviViews[i - 1] as FeedController
				theFeed.tableData.append(message)
				self.navigationController?.popToViewController(theFeed, animated: true)
			}}
	}
}
