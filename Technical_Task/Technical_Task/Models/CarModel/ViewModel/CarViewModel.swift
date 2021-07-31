//
//  CarViewModel.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 28/07/21.
//

import UIKit

//MARK: Protocol for data communication
protocol ViewModelProtocol: class {
    //MARK: Send data fetched from json to CarListViewController
    /**
      - Parameters:
        - carsData : This method will provide the cars data array fetched from local json
     */
    func getCarDetails(carsData:CarModel)
}

class CarViewModel {
    
//MARK: Variable
    weak var delegate : ViewModelProtocol?
    
//MARK: Fetch car details json from local file
    func getCarDetails(){
        self.delegate?.getCarDetails(carsData: Services.getCarDetails(fileName: Constants.LOCAL_JSON_FILE_NAME))
    }
    
}
