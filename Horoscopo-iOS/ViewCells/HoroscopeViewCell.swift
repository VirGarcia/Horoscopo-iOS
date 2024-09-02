//
//  HoroscopeViewCellsTableViewCell.swift
//  Horoscopo-iOS
//
//  Created by Mañanas on 29/7/24.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var datesLabel: UILabel!
    
   @IBOutlet weak var favoriteImageView: UIImageView!
    
    //estos dos métodos por ahora no van a hacer falta
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
  
    
    
    func render(horoscope: Horoscope) {
        nameLabel.text = horoscope.name
        datesLabel.text = horoscope.dates
        logoImageView.image = horoscope.image
    
        
        let favoriteHoroscope = UserDefaults.standard.string(forKey: "FAVORITE_HOROSCOPE") ?? ""
        let isFavorite = horoscope.id == favoriteHoroscope
        
        favoriteImageView.isHidden = !isFavorite
    }
}
