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
}
