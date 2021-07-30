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
    //MARK: create dynamic UILabel with bullet point
        /**
          - Parameters:
            - textTitle:Title for the Label
            - fontSize: Font size for the UILabel
            - color: Color  for the UILabel text
         */
    func createLabelDynamically(textTitle: String, fontSize: CGFloat, color: UIColor)-> UILabel {
        
        let labelHeight = textTitle.height(constraintedWidth: self.frame.width - 100, font: UIFont(name: FontConstants.HELVETICA_BOLD, size: fontSize)!)
        heightOfStackView = heightOfStackView + Double(labelHeight + 10)
        let label = UILabel(frame: CGRect(x: 20, y: CGFloat(heightOfStackView - Double(labelHeight)), width: self.frame.width - 70, height: labelHeight + 15))
        label.textColor = color
        let bulletSymbol = Constants.BULLET_POINT_STRING
        let range = (textTitle as NSString).range(of: bulletSymbol)
        let attributtedText = NSMutableAttributedString(string:textTitle)
        attributtedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orangeColor(), range: range)
        attributtedText.addAttribute(NSAttributedString.Key.font, value: UIFont(name: FontConstants.HELVETICA_BOLD, size: 20)!, range: range)
        label.font = UIFont(name: FontConstants.HELVETICA_BOLD, size: fontSize)
        
        label.attributedText = attributtedText
        label.numberOfLines = 0
        label.sizeToFit()
        return label
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
    
//MARK: Setup for cell expand & collapse with pros and cons in car model
        /**
          - Parameters:
            - carDetail:This will contain the complete data for the car model and used to set the info on cell
            - status: Status of the expand & collapse the cell
         */
    func setupProsAndCons(carDetail: CarModelElement, status: Bool) {
        if status == false {
            self.prosAndConsContainerStackView.isHidden = false
            heightOfStackView = 0
            if let prosCount = carDetail.prosList?.count {
                if prosCount > 0 {
                    let prosTitleLabel = self.createLabelDynamically(textTitle: Constants.PROS_STRING, fontSize: 15, color: .darkGrayColor())
                    self.prosAndConsContainerStackView.addSubview(prosTitleLabel)
                    
                }
                for index in 0..<prosCount{
                    let prosString = carDetail.prosList![index]
                    if prosString != "" {
                        let titleString = "\(Constants.BULLET_POINT_STRING)  \(prosString)"
                        let prosDescriptionLabel = self.createLabelDynamically(textTitle: titleString, fontSize: 13, color: .black)
                        self.prosAndConsContainerStackView.addSubview(prosDescriptionLabel)
                    }
                    
                }
            }
            if let consCount = carDetail.consList?.count {
                if consCount > 0{
                    let consTitleLabel = self.createLabelDynamically(textTitle: Constants.CONS_STRING, fontSize: 15, color: .darkGrayColor())
                    self.prosAndConsContainerStackView.addSubview(consTitleLabel)
                }
                for index in 0..<consCount{
                    let prosString = carDetail.consList![index]
                    if prosString != "" {
                        let titleString = "\(Constants.BULLET_POINT_STRING)  \(carDetail.consList![index])"
                        let consDescriptionLabel = self.createLabelDynamically(textTitle: titleString, fontSize: 13, color: .black)
                        self.prosAndConsContainerStackView.addSubview(consDescriptionLabel)
                    }
                }
            }
            self.prosAndConsStackViewHeightConstraint.constant = CGFloat(heightOfStackView)
        }else{
            self.prosAndConsContainerStackView.isHidden = true
            self.prosAndConsStackViewHeightConstraint.constant = 0
        }

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
//MARK: Provide formatted price string from the input integer value
    /**
      - Parameters:
        - price : input value of integer(price)
     */
    func formattedPriceStringFromInt(price:Int)->String{
        return "Price: \(price/1000)K"
    }
}
