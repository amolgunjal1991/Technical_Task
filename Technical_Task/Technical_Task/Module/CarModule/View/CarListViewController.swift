//
//  CarListViewController.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 27/07/21.
//

import UIKit


class CarListViewController: BaseViewController {
    
    // Outlets
    @IBOutlet private weak var carsTableView: UITableView!
    @IBOutlet private weak var filterTitleLabel: UILabel!
    @IBOutlet private weak var anyMakeTextfield: UITextField!
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var mainSubtitleLabel: UILabel!
    @IBOutlet private weak var anyModelTextField: UITextField!
    
    // Variables
    lazy var viewModel = CarViewModel()
    fileprivate var totalCarsDataArray: CarModels = []
    fileprivate var carsDataArray: CarModels = []
    fileprivate var carsMakeArray = [String]()
    fileprivate var carsModelArray = [String]()
    private var filterType: FilterByType = .none
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    // Function is used for the setting
    private func initializeUI() {
        setupNavigationBar(title: Constants.titleText, textColor: .white)
        setupFilterLabel()
        setUpLabelTitles()
        addShadowToTextfield(textFields: [anyModelTextField,anyMakeTextfield])
        carsTableView.register(UINib.init(nibName: TableCellConstants.carTableCell, bundle: nil), forCellReuseIdentifier: TableCellConstants.carTableCell)
        setupViewModel()
        carsTableView.reloadData()
        carsTableView.backgroundColor = .clear
        setLeftPaddingToTextFields()
        setupMakeModelDataSource()
    }
    
    // Set up view model
    func setupViewModel(){
        viewModel.delegate = self
        viewModel.getCarDetails()
        viewModel.setupInitialStatusExpandAndCollapseCells(countOfCell: carsDataArray.count)
    }
    
    func setUpLabelTitles(){
        anyMakeTextfield.placeholder = Constants.anyMakeFilter
        anyModelTextField.placeholder = Constants.anyModelFilter
        mainTitleLabel.text = Constants.mainLabelTitle
        mainSubtitleLabel.text = Constants.mainSubLabelTitle
    }
    
    // Function used to set make and model array for the displaying dropdown for filter
    private func setupMakeModelDataSource() {
        self.carsMakeArray = viewModel.getMakeTypeArray()
        self.carsModelArray = viewModel.getModelTypeArray()
    }
    
    // Function for setting left padding for the filter textfields
    private func setLeftPaddingToTextFields() {
        anyMakeTextfield.setLeftPaddingPoints(10)
        anyModelTextField.setLeftPaddingPoints(10)
    }
    
    // Function displays alert with the list of filter type with the
    private func addAlertWithMultipleActions(alertTitle: String,
                                             actionTitles: [String]) {
        let alert = UIAlertController(title: "\(Constants.filterByInitialTitle) \(alertTitle)", message: Constants.emptyString, preferredStyle: .alert)
        alert.view.tintColor = .black
        for actionTitle in actionTitles {
            let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                self.filterWithTheString(filterString: actionTitle, byType: alertTitle)
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
        }
        let cancelActon = UIAlertAction(title: Constants.cancelString, style: .destructive) { (action) in
            switch self.filterType {
            case .make:
                self.filterWithTheString(filterString: Constants.emptyString, byType: Constants.emptyString)
                break
            case .model:
                if let maketfText = self.anyMakeTextfield.text {
                    self.filterWithTheString(filterString: maketfText, byType: Constants.make)
                }
                break
            default :
                self.filterWithTheString(filterString: Constants.emptyString, byType: Constants.emptyString)
                break
            }
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelActon)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Function is used to set the filter type for make or model and reload car list data
    private func filterWithTheString(filterString: String,
                                     byType: String) {
        let responseOfFilter = viewModel.filterWithTheString(filterString: filterString, byType: byType)
        
        switch byType {
        case Constants.make:
            anyMakeTextfield.text = responseOfFilter.makelTextField
            anyModelTextField.text = Constants.emptyString
        case Constants.model :
            anyModelTextField.text = responseOfFilter.modelTextField
        default:
            anyModelTextField.text = Constants.emptyString
            anyMakeTextfield.text = Constants.emptyString
        }
        carsDataArray = responseOfFilter.carDataModel
        carsModelArray = responseOfFilter.makeArray
        viewModel.setupInitialStatusExpandAndCollapseCells(countOfCell: carsDataArray.count)
        DispatchQueue.main.async {
            self.carsTableView.reloadData()
        }
    }
    
    @IBAction func filterByMakeButtonTapped(_ sender: UIButton) {
        filterType = .make
        addAlertWithMultipleActions(alertTitle: Constants.make, actionTitles: viewModel.getMakeTypeStringsArray())
    }
    
    @IBAction func filterByModelButtonTapped(_ sender: UIButton) {
        filterType = .model
        if self.anyMakeTextfield.text == Constants.emptyString {
            self.showToast(message: Constants.toastMessageString, duration: ToastConfigue.duration)
        } else {
            if let textFieldTitle = self.anyMakeTextfield.text {
                addAlertWithMultipleActions(alertTitle: Constants.model, actionTitles: viewModel.provideListOfModelWithMakeName(inputMakeName: textFieldTitle))
            }
        }
    }
    
    // MARK: Setup filter label
    private func setupFilterLabel() {
        filterTitleLabel.text = Constants.filterTitleLabel
        filterTitleLabel.textColor = .white
    }
    
    // MARK: Populate data for the cell
    /**
     - Parameters:
     - cell : CarsTableViewCell to populate the data
     - indexPath : indexPath to get the data from the collection for perticular cell
     */
    private func populateData(_ cell: CarsTableViewCell,
                              _ indexPath:IndexPath,
                              _ status:Bool) -> UITableViewCell {
        let carDetail = carsDataArray[indexPath.row]
        cell.setUpInitialData(with: carDetail.make, model: carDetail.model, price: carDetail.customerPrice, rating: carDetail.rating, status: status, imageName: carDetail.image, prosList: carDetail.prosList, consList: carDetail.consList)
        return cell
    }
}

// MARK: Tableview Delegate & Datasource
extension CarListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellConstants.carTableCell, for: indexPath) as? CarsTableViewCell else {
            fatalError(Constants.fetchErrorMessage)
        }
        let status = self.viewModel.expandCollapseStatusArray[indexPath.row]
        return populateData(cell, indexPath, status)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for indexNumber in 0..<viewModel.expandCollapseStatusArray.count {
            viewModel.expandCollapseStatusArray[indexNumber] = true
        }
        viewModel.expandCollapseStatusArray[indexPath.row] = false
        UIView.transition(with: carsTableView,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.carsTableView.reloadData()
                            self.carsTableView.scrollToRow(at: IndexPath(row:indexPath.row, section: 0), at: .top, animated: true)
                          })
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: Delegate method to get the array of cars from ViewModel
extension CarListViewController : ViewModelProtocol {
    
    func getCarDetails(carsData: CarModels) {
        self.carsDataArray = carsData
        self.totalCarsDataArray = carsData
        DispatchQueue.main.async {
            self.carsTableView.reloadData()
        }
    }
}

