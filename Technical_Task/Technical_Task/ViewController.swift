//
//  ViewController.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 27/07/21.
//

import UIKit

class CarListTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "car_list", ofType: "json")
        let carInfoArray = self.parseLocalJson(with: path)
        print("Car info Array:",carInfoArray)
    }
    private func parseLocalJson(with path:String?)->CarModel{
        guard let path = path else {
            return CarModel()
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(CarModel.self, from: data)
            return jsonData
        }catch {
            fatalError("Unable to fetch the file")
        }
    }

}

