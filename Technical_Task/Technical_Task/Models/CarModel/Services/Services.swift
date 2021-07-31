//
//  Services.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 30/07/21.
//

import Foundation

class Services {
    
    //MARK: Fetch car details json from local file
    static func getCarDetails(fileName: String)-> CarModel{
            let urlForResource = Bundle.main.path(forResource: fileName, ofType: Constants.FILE_EXTENSION_TYPE_JSON)
            guard let path = urlForResource else {
                return CarModel()
            }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let carData = try decoder.decode(CarModel.self, from: data)
                return carData
            }catch {
                fatalError(Constants.FETCH_ERROR_MESSAGE)
            }
        }
}