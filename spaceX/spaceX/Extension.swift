//
//  Extension.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import Foundation
import Foundation
import UIKit

extension UIViewController {
    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
