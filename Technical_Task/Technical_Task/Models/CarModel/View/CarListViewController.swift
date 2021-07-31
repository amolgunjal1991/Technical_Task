//
//  CarListViewController.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 27/07/21.
//

import UIKit


class CarListViewController: BaseViewController{
    //Outlets
    @IBOutlet private weak var carsTableView: UITableView!
    
    @IBOutlet private weak var filterTitleLabel: UILabel!
    @IBOutlet private weak var anyMakeTextfield: UITextField!
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var mainSubtitleLabel: UILabel!
    @IBOutlet private weak var anyModelTextField: UITextField!
    //Variables
  
    lazy var viewModel : CarViewModel? = CarViewModel()
    var totalCarsDataArray : CarModel = []
    var carsDataArray : CarModel = []
    var carsMakeArray = [String]()
    var carsModelArray = [String]()
    var expandCollapseStatusArray : [Bool] = []
    
    enum FilterByType {
        case make
        case model
        case none
    }
    
    var filterType : FilterByType = .none
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     initialize()
    }
    
    func initialize(){
        setupNavigationBar(title: Constants.TITLE_TEXT, textColor: .white)
        setupFilterLabel()
        anyMakeTextfield.placeholder = Constants.ANY_MAKE_FILTER
        anyModelTextField.placeholder = Constants.ANY_MODEL_FILTER
        mainTitleLabel.text = Constants.MAIN_LABEL_TITLE
        mainSubtitleLabel.text = Constants.MAIN_SUBLABEL_TITLE
        addShadowToTextfield(textFields: [anyModelTextField,anyMakeTextfield])
        carsTableView.register(UINib.init(nibName: TableCellConstants.carTableCell, bundle: nil), forCellReuseIdentifier: TableCellConstants.carTableCell)
        viewModel?.delegate = self
        viewModel?.getCarDetails()
        setupInitialStatusExpandAndCollapseCells(countOfCell: carsDataArray.count)
        carsTableView.backgroundColor = .clear
        setupMakeModelDataSource()
    }
    
    
    func setupMakeModelDataSource(){
        self.carsMakeArray = viewModel!.getMakeTypeArray()
        self.carsModelArray = viewModel!.getModelTypeArray()
    }
    
    func addAlertWithMultipleActions(alertTitle: String, actionTitles: [String]) {
        let alert = UIAlertController(title: "\(Constants.FILTER_BY_INITIAL_STR) \(alertTitle)", message: .empty, preferredStyle: .alert)
        alert.view.tintColor = .black
        for actionTitle in actionTitles {
            let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                self.filterWithTheString(filterString: actionTitle, byType: alertTitle)
            
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
        }
        let cancelActon = UIAlertAction(title: Constants.CANCEL_STRING, style: .destructive) { (action) in
            switch self.filterType {
            case .make:
                self.filterWithTheString(filterString: .empty, byType: .empty)
                break
            case .model:
                if let maketfText = self.anyMakeTextfield.text {
                    self.filterWithTheString(filterString: maketfText, byType: Constants.MAKE)
                }
                break
            default :
                self.filterWithTheString(filterString: .empty, byType: .empty)
                break
            }
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelActon)
        self.present(alert, animated: true, completion: nil)
    }
    
    func filterWithTheString(filterString: String, byType: String){
        guard let responseOfFilter = viewModel?.filterWithTheString(filterString: filterString, byType: byType) else{
            return
        }
        
        switch byType {
        case Constants.MAKE:
            anyMakeTextfield.text = responseOfFilter.makeTf
            anyModelTextField.text = .empty
        case Constants.MODEL :
            anyModelTextField.text = responseOfFilter.madelTf
        default:
            anyModelTextField.text = .empty
            anyMakeTextfield.text = .empty
        }
        carsDataArray = responseOfFilter.carDataModel
        carsModelArray = responseOfFilter.makeArray
        setupInitialStatusExpandAndCollapseCells(countOfCell: carsDataArray.count)
        DispatchQueue.main.async {
            self.carsTableView.reloadData()
        }
    }
    
    
    @IBAction func filterByMakeButtonTapped(_ sender: UIButton) {
        filterType = .make
        addAlertWithMultipleActions(alertTitle: Constants.MAKE, actionTitles: carsMakeArray)
        
    }
    @IBAction func filterByModelButtonTapped(_ sender: UIButton) {
        filterType = .model
        if self.anyMakeTextfield.text == .empty {
            self.showToast(message: Constants.TOAST_MESSAGE_STRING, duration: ToastConfigue.duration)
        } else {
            addAlertWithMultipleActions(alertTitle: Constants.MODEL, actionTitles: carsModelArray)
        }
    }
    
    
//MARK: Setup filter label
    func setupFilterLabel(){
        filterTitleLabel.text = Constants.FILTER_TITLE_LABEL
        filterTitleLabel.font = UIFont(name: FontConstants.HELVETICA_BOLD, size: 18)
        filterTitleLabel.textColor = .white
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
        self.carsTableView.reloadData()
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
        self.totalCarsDataArray = carsData
        DispatchQueue.main.async {
            self.carsTableView.reloadData()
        }
    }
}

