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
    var totalCarArray : CarModel = []

//MARK: Fetch car details json from local file
    func getCarDetails(){
        totalCarArray = Services.getCarDetails(fileName: Constants.LOCAL_JSON_FILE_NAME)
        self.delegate?.getCarDetails(carsData: totalCarArray)
    }
    
    func getMakeTypeArray()-> [String]{
        return self.totalCarArray.map({$0.make!})

    }
    func getModelTypeArray()-> [String]{
        return self.totalCarArray.map({$0.model!})
    }
    
    func filterWithTheString(filterString: String, byType: String)-> (carDataModel: CarModel,makeArray: [String],makeTf: String, madelTf: String) {
        var carsDataArray : CarModel = []
        var carModelTypeName = [String]()
        var makeText : String = .empty
        var modelText : String = .empty
        switch byType {
        case Constants.MAKE:
            carsDataArray = totalCarArray.filter({$0.make == filterString})
            carModelTypeName = carsDataArray.map({$0.model!})
            makeText = filterString
            modelText = .empty
        case Constants.MODEL:
            carsDataArray = totalCarArray.filter({$0.model == filterString})
            modelText = filterString
        default:
            carsDataArray = totalCarArray
            modelText = .empty
            makeText = .empty
        }
        return (carDataModel: carsDataArray,makeArray: carModelTypeName,makeTf: makeText, madelTf: modelText)
    }
    
}
