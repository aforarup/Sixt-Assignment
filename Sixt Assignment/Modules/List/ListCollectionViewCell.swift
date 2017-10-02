//
//  ListTableViewCell.swift
//  Sixt Assignment
//
//  Created by Arup Saha on 10/1/17.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var licensePlate: UILabel!
    @IBOutlet weak var makeLbl: UILabel!
    
    @IBOutlet weak var txTypeLbl: UILabel!
    
    @IBOutlet weak var fuelTypeLbl: UILabel!
    @IBOutlet weak var fuelMeterLbl: UILabel!
    
    @IBOutlet weak var cleanlinessLbl: UILabel!
    override func awakeFromNib() {
        
    }
    
    override func prepareForReuse() {
        nameLbl.text = ""
        imgView.image = nil
    }
}
