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
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var brandNamelabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    
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
//MARK: Initial setup for cell component's with their values
    /**
      - Parameters:
        - carDetail:This will contain the complete data for the car model and used to set the info on cell
     */
    func setUpInitialData(carDetail:CarModelElement){
        if let make = carDetail.name {
        brandNamelabel.text = make
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
