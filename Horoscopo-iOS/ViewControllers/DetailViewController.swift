//
//  DetailViewController.swift
//  Horoscopo-iOS
//
//  Created by Mañanas on 30/7/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var horoscope: Horoscope? = nil
    var horoscopeIndex:Int = -1
    var isFavorite: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Este if permite eliminar el opcional y asignarlo en una nueva variable
               if let horoscope = horoscope {
                   nameLabel.text = horoscope.name
                   logoImageView.image = horoscope.image
                   datesLabel.text = horoscope.dates
               }
        
        loadData()
    }
    
    @IBAction func setFavorite(_ sender: UIBarButtonItem) {
        isFavorite = !isFavorite
                if (isFavorite) {
                    UserDefaults.standard.setValue(horoscope?.id, forKey: "FAVORITE_HOROSCOPE")
                } else {
                    UserDefaults.standard.setValue("", forKey: "FAVORITE_HOROSCOPE")
                }
                setFavoriteButtomItem()
    }
    
    @IBAction func goToPrev(_ sender: UIButton) {
        if (horoscopeIndex == 0) {
            horoscopeIndex = HoroscopeProvider.getAllHoroscopes().count
        }
        horoscopeIndex -= 1
        horoscope = HoroscopeProvider.getAllHoroscopes()[horoscopeIndex]
        loadData()
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        horoscopeIndex += 1
        if (horoscopeIndex == HoroscopeProvider.getAllHoroscopes().count) {
            horoscopeIndex = 0
        }
        horoscope = HoroscopeProvider.getAllHoroscopes()[horoscopeIndex]
        loadData()
    }
    func loadData() {
            let favoriteHoroscope = UserDefaults.standard.string(forKey: "FAVORITE_HOROSCOPE") ?? ""
            isFavorite = horoscope?.id == favoriteHoroscope
            
            setFavoriteButtomItem()
            
            
            self.navigationItem.title = horoscope?.name
            nameLabel.text = horoscope?.name
            logoImageView.image = horoscope?.image
            
            getHoroscopeLuck()
        }
    
    func setFavoriteButtomItem() {
            if (isFavorite) {
                favoriteButtonItem.image = UIImage(systemName: "heart.fill")
            } else {
                favoriteButtonItem.image = UIImage(systemName: "heart")
            }
        }
    
    func getHoroscopeLuck() {
        Task {
            do {
                let luck = try await HoroscopeProvider.getHoroscopeLuck(horoscopeId: horoscope!.id)
                
                descriptionTextView.text = luck
            } catch {
                print(error)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
