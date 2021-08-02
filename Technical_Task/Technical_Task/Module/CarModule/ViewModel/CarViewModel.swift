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
    func getCarDetails(carsData:CarModels)
}

class CarViewModel {
    
    // MARK: Variable
    weak var delegate: ViewModelProtocol?
    var totalCarArray: CarModels = []
    var expandCollapseStatusArray: [Bool] = []
    var filterbyMakeArray: CarModels = []
    var filterbyModelArray: CarModels = []
    
    // MARK: Fetch car details json from local file
    func getCarDetails() {
        totalCarArray = Services.getCarDetails(fileName: Constants.localJsonFileName)
        self.delegate?.getCarDetails(carsData: totalCarArray)
    }
    
    // Function gives the make list of the car
    func getMakeTypeArray() -> [String] {
        return self.totalCarArray.map({$0.make ?? ""})
    }
    
    // Function gives the model list of the car
    func getModelTypeArray() -> [String] {
        return self.totalCarArray.map({$0.model ?? ""})
    }
    
    // Function gives the model list of the car
    func getMakeTypeStringsArray() -> [String] {
        return self.totalCarArray.map({$0.make ?? ""})
    }
    
    // Function to return formatted string for price
    func priceFormattedString(price: Int) -> String {
        return "Price : \(price)k"
    }
    
    // MARK: Setup expand & collapse status array initially
    func setupInitialStatusExpandAndCollapseCells(countOfCell:Int?) {
        if let totalCell = countOfCell {
            for statusCount in 0..<totalCell {
                if statusCount == 0 {
                    self.expandCollapseStatusArray.append(false)
                }else{
                    self.expandCollapseStatusArray.append(true)
                }
            }
        }
    }
    
    // This function returns the list of model for given make
    func provideListOfModelWithMakeName(inputMakeName: String) -> [String] {
        return self.totalCarArray.filter({$0.make == inputMakeName}).map({$0.model ?? ""})
    }
    
    // Filter the car list with provided make or model and returns the result according to that
    func filterWithTheString(filterString: String,
                             byType: String) -> CarFilterStruct {
        var carsDataArray : CarModels = []
        var carModelTypeName = [String]()
        var makeText : String = Constants.emptyString
        var modelText : String = Constants.emptyString
        
        switch byType {
        case Constants.make:
            carsDataArray = totalCarArray.filter({$0.make == filterString})
            carModelTypeName = carsDataArray.map({$0.model ?? ""})
            makeText = filterString
            modelText = Constants.emptyString
        case Constants.model:
            carsDataArray = totalCarArray.filter({$0.model == filterString})
            modelText = filterString
        default:
            carsDataArray = totalCarArray
        }
        
        return CarFilterStruct(carDataModel: carsDataArray,
                               makeArray: carModelTypeName,
                               modelTextField: modelText,
                               makelTextField: makeText)
    }
    
}
