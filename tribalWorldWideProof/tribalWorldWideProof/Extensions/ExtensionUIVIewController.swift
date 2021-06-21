//
//  ExtensionUIVIewController.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 18/06/21.
//

import Foundation
import UIKit

extension UIViewController{
    func getFormattedDate(isoDate: String, format: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
    }
    
    func genericAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
