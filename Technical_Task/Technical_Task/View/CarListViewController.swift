//
//  CarListViewController.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 27/07/21.
//

import UIKit


class CarListViewController: BaseViewController{
    //Outlets
    @IBOutlet weak var carsTableView: UITableView!
    
    //Variables
    lazy var viewModel : CarViewModel? = CarViewModel()
    var carsDataArray : CarModel = []
    var expandCollapseStatusArray : [Bool] = []
    
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     initialize()
    }
    func initialize(){
        setupNavigationBar(title: Constants.TITLE_TEXT, textColor: .white)
        carsTableView.register(UINib.init(nibName: TableCellConstants.carTableCell, bundle: nil), forCellReuseIdentifier: TableCellConstants.carTableCell)
        viewModel?.delegate = self
        viewModel?.getCarDetails()
        setupInitialStatusExpandAndCollapseCells(countOfCell: carsDataArray.count)
    }
    
//MARK: Setup expand & collapse status array initially
    func setupInitialStatusExpandAndCollapseCells(countOfCell:Int?){
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
    
//MARK: Populate data for the cell
    /**
      - Parameters:
        - cell : CarsTableViewCell to populate the data
        - indexPath : indexPath to get the data from the collection for perticular cell
     */
    private func populateData(_ cell:CarsTableViewCell,_ indexPath:IndexPath,_ status:Bool)-> UITableViewCell{
        let carDetail = carsDataArray[indexPath.row]
        cell.setUpInitialData(carDetail: carDetail,status: status)
        return cell
    }
}

//MARK: Tableview Delegate & Datasource
extension CarListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellConstants.carTableCell, for: indexPath) as? CarsTableViewCell else{
            fatalError(Constants.FETCH_ERROR_MESSAGE)
        }
        let status = self.expandCollapseStatusArray[indexPath.row]
        return populateData(cell, indexPath, status)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for indexNumber in 0..<expandCollapseStatusArray.count {
            expandCollapseStatusArray[indexNumber] = true
        }
        expandCollapseStatusArray[indexPath.row] = false
        carsTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
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
