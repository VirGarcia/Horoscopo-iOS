//
//  ViewController.swift
//  Horoscopo-iOS
//
//  Created by Mañanas on 29/7/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var horoscopeList: [Horoscope] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        horoscopeList = HoroscopeProvider.getAllHoroscopes()
        
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horoscopeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoroscopeViewCell
                
                let horoscope = horoscopeList[indexPath.row]
                
                cell.render(horoscope: horoscope)
                
                return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Preguntamos cual es el identificador del segue
           if segue.identifier == "navigateToDetail" {
               // Obtenemos el viewController de destino
               let viewController = segue.destination as! DetailViewController
               // Obtenemos la celda seleccionada
               let indexPath = tableView.indexPathForSelectedRow!
               // Asignamos en detalle el horoscopo que corresponde a la celda seleccionada
               viewController.horoscope = horoscopeList[indexPath.row]
               viewController.horoscopeIndex = indexPath.row
               // Deseleccionamos la celda para que no aparezca marcada
               tableView.deselectRow(at: indexPath, animated: false)
           }
       }
    
    


}


