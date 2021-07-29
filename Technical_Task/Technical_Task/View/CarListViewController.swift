//
//  CarListViewController.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 27/07/21.
//

import UIKit


class CarListViewController: UIViewController{
    //Outlets
    @IBOutlet weak var carsTableView: UITableView!
    
    //Variables
    lazy var viewModel : CarViewModel? = CarViewModel()
    var carsDataArray : CarModel?
    
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "GUIDOMIA", textColor: .white)
        carsTableView.register(UINib.init(nibName: TableCellConstants.carTableCell, bundle: nil), forCellReuseIdentifier: TableCellConstants.carTableCell)
        viewModel?.delegate = self
        viewModel?.getCarDetails()
    }
    
//MARK: Populate data for the cell
    /**
      - Parameters:
        - cell : CarsTableViewCell to populate the data
        - indexPath : indexPath to get the data from the collection for perticular cell
     */
    private func populateData(_ cell:CarsTableViewCell,_ indexPath:IndexPath)->UITableViewCell{
        guard let carDetail = carsDataArray?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setUpInitialData(carDetail: carDetail)
        return cell
    }
    
//MARK: Set title to the left of navigation bar
    /**
      - Parameters:
        - title : Title string for the navigation bar
        - textColor : Pass te uicolor for the text of the navigation bar
     */
    func setupNavigationBar(title:String,textColor:UIColor){
        if let navigationBar = self.navigationController?.navigationBar {
            let letfNavigationBarTitle = CGRect(x: 20, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            let titleLabel = UILabel(frame: letfNavigationBarTitle)
            titleLabel.textColor = textColor
            titleLabel.text = title
            navigationBar.addSubview(titleLabel)
        }
    }
}

//MARK: Tableview Delegate & Datasource
extension CarListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsDataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellConstants.carTableCell, for: indexPath) as? CarsTableViewCell else{
            fatalError(Constants.FETCH_ERROR_MESSAGE)
        }
        return populateData(cell, indexPath)
    }
}

//MAEK: Delegate method to get the array of cars from ViewModel
extension CarListViewController : ViewModelProtocol {

    func getCarDetails(carsData: CarModel) {
        self.carsDataArray = carsData
        DispatchQueue.main.async {
            self.carsTableView.reloadData()
        }
    }
}
