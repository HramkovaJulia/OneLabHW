//
//  Model.swift
//  OneLabHW4
//
//  Created by Artyom Prima on 08.04.2023.
//

import Foundation
import UIKit

struct Settings {
    let sections: [Section]
}

struct Section {
    let title: String
    let settings: [Setting]
}

struct Setting {
    let title: String
    let imageName: String
    let color: UIColor
}
