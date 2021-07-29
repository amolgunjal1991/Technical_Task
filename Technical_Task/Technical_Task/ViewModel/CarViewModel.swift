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
        let urlForResource = Bundle.main.path(forResource: "car_list", ofType: "json")
        guard let path = urlForResource else {
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let carData = try decoder.decode(CarModel.self, from: data)
            self.delegate?.getCarDetails(carsData: carData)
        }catch {
            fatalError(Constants.FETCH_ERROR_MESSAGE)
        }
    }
}
