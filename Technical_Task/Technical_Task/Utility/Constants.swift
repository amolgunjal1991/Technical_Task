//
//  Constants.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 28/07/21.
//

import Foundation

struct Constants {
    // MARK:- Error message cosntant
    static let fetchErrorMessage = "Unable to fetch data from json"
    
    // MARK:- Label title text constants strings
    static let titleText = "GUIDOMIA"
    static let consString = "Cons :"
    static let prosString = "Pros :"
    static let bulletPointString = " \u{2022}"
    static let filterTitleLabel = "Filters"
    static let anyMakeFilter = "Any make"
    static let anyModelFilter = "Any model"
    static let mainSubLabelTitle = "Get your's now"
    static let toastMessageString = "Please select the make first"
    static let cancelString = "Cancel"
    static let filterByInitialTitle = "Filter by"
    static let make = "make"
    static let model = "model"
    
    // MARK:- Model Constants
    static let localJsonFileName = "car_list"
    static let fileExtensionTypeJson = "json"
    static let mainLabelTitle = "Tacoma 2021"
    
    // MARK:- Empty String
    static let emptyString = ""
    
    // MARK:- Corner radius constants
    static let cornerRadius = 5.0
    
    
}

// Tableview cell cosntants
struct TableCellConstants {
    static let carTableCell = "CarsTableViewCell"
}

// Font name cosntants
struct FontConstants {
    static let helveticaBold = "Helvetica-Bold"
    static let HelveticaRegular = "Helvetica-Regular"
}

// Toast duration constant
struct ToastConfigue {
    static let duration = 3.0
}


// Filter by type enum's
enum FilterByType {
    case make
    case model
    case none
}
