//
//  CarsTableViewCell.swift
//  Technical_Task
//
//  Created by Amol Gunjal on 28/07/21.
//

import UIKit
import Cosmos


class CarsTableViewCell: UITableViewCell {
//Outlets
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var brandNamelabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var prosAndConsContainerStackView: UIStackView!
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var prosAndConsStackViewHeightConstraint: NSLayoutConstraint!
    
//Variables
    var heightOfStackView = 0.0
    
//MARK: lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.mainView.backgroundColor = .lightGrayColor()
        brandNamelabel.textColor = .darkGrayColor()
        priceLabel.textColor = .darkGrayColor()
        setupRatingView()
    }
 

//MARK: Setup for rating view with some default values
   private func setupRatingView(){
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starSize = 20
        ratingView.settings.starMargin = 5
        ratingView.settings.filledColor = .orangeColor()
        ratingView.settings.fillMode = .full
    }
    
//MARK: lifecycle
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
//MARK: Provide formatted name string from the make and model
        /**
          - Parameters:
            - make : Make of the car
            - model : Model of the car
         */
    func formatModelNameFromMakeAndModel(make:String, model:String)-> String{
        return "\(make) \(model)"
    }
    
//MARK: Initial setup for cell component's with their values
    /**
      - Parameters:
        - carDetail:This will contain the complete data for the car model and used to set the info on cell
        - status: Status of the expand & collapse the cell
     */
    func setUpInitialData(carDetail:CarModelElement,status:Bool){
        if let make = carDetail.make,let model = carDetail.model {
            brandNamelabel.text = self.formatModelNameFromMakeAndModel(make: make, model: model)
        }
        if let price = carDetail.customerPrice {
            priceLabel.text = self.formattedPriceStringFromInt(price: price)
        }
        if let imageName = carDetail.image{
            carImageView.image = UIImage(named: imageName)
        }
        if let rating = carDetail.rating {
            ratingView.rating = Double(rating)
        }
        setupProsAndCons(carDetail: carDetail, status: status)
    }
    
    //MARK: Provide formatted price string from the input integer value
        /**
          - Parameters:
            - price : input value of integer(price)
         */
        func formattedPriceStringFromInt(price:Int)->String{
            return "Price: \(price/1000)k"
        }
//MARK: Setup for cell expand & collapse with pros and cons in car model
        /**
          - Parameters:
            - carDetail:This will contain the complete data for the car model and used to set the info on cell
            - status: Status of the expand & collapse the cell
         */
    func setupProsAndCons(carDetail: CarModelElement, status: Bool) {
        if status == false {
            for view in self.prosAndConsContainerStackView.subviews {
                view.removeFromSuperview()
            }
            self.prosAndConsContainerStackView.isHidden = false
            heightOfStackView = 0
            if let prosCount = carDetail.prosList?.count {
                if prosCount > 0 {
                    let prosTitleLabel = UtilityManager.createLabelDynamically(textTitle: Constants.PROS_STRING, fontSize: 15, color: .darkGrayColor(), width: self.frame.width - 70, heightOfStack: heightOfStackView)
                    heightOfStackView = prosTitleLabel.1
                    self.prosAndConsContainerStackView.addSubview(prosTitleLabel.0)
                    
                }
                for index in 0..<prosCount{
                    let prosString = carDetail.prosList![index]
                    if prosString != "" {
                        let titleString = "\(Constants.BULLET_POINT_STRING)  \(prosString)"
                        let prosDescriptionLabel = UtilityManager.createLabelDynamically(textTitle: titleString, fontSize: 13, color: .black, width: self.frame.width - 70, heightOfStack: heightOfStackView)
                        heightOfStackView = prosDescriptionLabel.1
                        self.prosAndConsContainerStackView.addSubview(prosDescriptionLabel.0)
                    }
                    
                }
            }
            if let consCount = carDetail.consList?.count {
                if consCount > 0{
                    let consTitleLabel = UtilityManager.createLabelDynamically(textTitle: Constants.CONS_STRING, fontSize: 15, color: .darkGrayColor(), width: self.frame.width - 70, heightOfStack: heightOfStackView)
                    heightOfStackView = consTitleLabel.1
                    self.prosAndConsContainerStackView.addSubview(consTitleLabel.0)
                }
                for index in 0..<consCount{
                    let prosString = carDetail.consList![index]
                    if prosString != "" {
                        let titleString = "\(Constants.BULLET_POINT_STRING)  \(carDetail.consList![index])"
                        
                        let consDescriptionLabel = UtilityManager.createLabelDynamically(textTitle: titleString, fontSize: 13, color: .black, width: self.frame.width - 70, heightOfStack: heightOfStackView)
                        heightOfStackView = consDescriptionLabel.1
                        self.prosAndConsContainerStackView.addSubview(consDescriptionLabel.0)
                    }
                }
            }
            self.prosAndConsStackViewHeightConstraint.constant = CGFloat(heightOfStackView)
        }else{
            self.prosAndConsContainerStackView.isHidden = true
            for view in self.prosAndConsContainerStackView.subviews {
                view.removeFromSuperview()
            }
            self.prosAndConsStackViewHeightConstraint.constant = 0
        }
    }
    


}
