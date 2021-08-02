//
//  CarsTableViewCell.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 28/07/21.
//

import UIKit
import Cosmos


class CarsTableViewCell: UITableViewCell {
    // Outlets
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var brandNamelabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var prosAndConsContainerStackView: UIStackView!
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var prosAndConsStackViewHeightConstraint: NSLayoutConstraint!
    
    // Variables
    private var heightOfStackView = 0.0
    lazy var viewModel = CarViewModel()
    
    // MARK: lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Set initial values for the component from of the cell when it get intialize first time
    private func initializeUI() {
        selectionStyle = .none
        self.mainView.backgroundColor = .lightGrayColor()
        brandNamelabel.textColor = .darkGrayColor()
        priceLabel.textColor = .darkGrayColor()
        setupRatingView()
    }
    
    // Setup for rating view with some default values
    private func setupRatingView(){
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starSize = 20
        ratingView.settings.starMargin = 5
        ratingView.settings.filledColor = .orangeColor()
        ratingView.settings.fillMode = .full
    }
    
    // Initial setup for cell component's with their values
    func setUpInitialData(with make: String?,
                          model: String?,
                          price: Int?,
                          rating: Int?,
                          status: Bool,
                          imageName: String?,
                          prosList: [String]?,
                          consList: [String]?) {
        if let make = make,let model = model {
            brandNamelabel.text = make.concatinateTwoStrings(concatString: model)
        }
        if let price = price {
            priceLabel.text = viewModel.priceFormattedString(price: price.convertPriceIntoThousand())
        }
        if let imageName = imageName{
            carImageView.image = UIImage(named: imageName)
        }
        if let rating = rating {
            ratingView.rating = Double(rating)
        }
        setupProsAndCons(prosList: prosList, consList: consList, status: status)
    }
    
    // MARK: Setup for cell expand & collapse with pros and cons in car model
    /**
     - Parameters:
     - carDetail:This will contain the complete data for the car model and used to set the info on cell
     - status: Status of the expand & collapse the cell
     */
    private func setupProsAndCons(prosList: [String]?,
                                  consList: [String]?,
                                  status: Bool) {
        if status == false {
            for view in self.prosAndConsContainerStackView.subviews {
                view.removeFromSuperview()
            }
            self.prosAndConsContainerStackView.isHidden = false
            heightOfStackView = 0
            if let prosCount = prosList?.count {
                if prosCount > 0 {
                    let prosTitleLabel = UtilityManager.createLabelDynamically(textTitle: Constants.prosString, fontSize: 17, color: .darkGrayColor(), width: self.frame.width - 15, heightOfStack: heightOfStackView)
                    heightOfStackView = prosTitleLabel.1
                    self.prosAndConsContainerStackView.addSubview(prosTitleLabel.0)
                }
                for index in 0..<prosCount{
                    if let prosList = prosList {
                        let prosString = prosList[index]
                        if prosString != Constants.emptyString {
                            let titleString = "  \(prosString)"
                            let prosDescriptionLabel = UtilityManager.createStackViewOfBulletLabel(textTitle: titleString, fontSize: 14, color: .black, width: self.frame.width - 15, heightOfStack: heightOfStackView)
                            heightOfStackView = prosDescriptionLabel.1
                            self.prosAndConsContainerStackView.addSubview(prosDescriptionLabel.0)
                        }
                    }
                }
            }
            if let consCount = consList?.count {
                if consCount > 0{
                    let consTitleLabel = UtilityManager.createLabelDynamically(textTitle: Constants.consString, fontSize: 17, color: .darkGrayColor(), width: self.frame.width - 15, heightOfStack: heightOfStackView)
                    heightOfStackView = consTitleLabel.1
                    self.prosAndConsContainerStackView.addSubview(consTitleLabel.0)
                }
                for index in 0..<consCount{
                    if let consList = consList {
                        let consString = consList[index]
                        if consString != Constants.emptyString {
                            let titleString = "  \(consList[index])"
                            let consDescriptionLabel = UtilityManager.createStackViewOfBulletLabel(textTitle: titleString, fontSize: 14, color: .black, width: self.frame.width - 15, heightOfStack: heightOfStackView)
                            heightOfStackView = consDescriptionLabel.1
                            self.prosAndConsContainerStackView.addSubview(consDescriptionLabel.0)
                        }
                    }
                }
            }
            self.prosAndConsStackViewHeightConstraint.constant = CGFloat(heightOfStackView)
        } else {
            self.prosAndConsContainerStackView.isHidden = true
            for view in self.prosAndConsContainerStackView.subviews {
                view.removeFromSuperview()
            }
            self.prosAndConsStackViewHeightConstraint.constant = 0
        }
    }
}
