//
//  CarModel.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 28/07/21.
//

import Foundation


// MARK: - CarModelElement
struct CarModelElement: Codable {
    let consList: [String]?
    let customerPrice: Int?
    let make: String?
    let marketPrice: Int?
    let model: String?
    let prosList: [String]?
    let rating: Int?
    let image: String?
 
}

typealias CarModel = [CarModelElement]
