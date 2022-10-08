//
//  BaseViewController.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    let activityView = UIActivityIndicatorView(style: .large)
    
    // MARK: - Life Cyc
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func showActivityIndicatory() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideActivityIndicatory() {
        activityView.removeFromSuperview()
        activityView.stopAnimating()
    }
}
