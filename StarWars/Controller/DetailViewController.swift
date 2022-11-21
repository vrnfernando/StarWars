//
//  DetailViewController.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lb_planetName: UILabel!
    @IBOutlet weak var lb_orbitalPeriod: UILabel!
    @IBOutlet weak var lb_gravity: UILabel!
    
    @IBOutlet weak var hStackView: UIStackView!
    var result: Result_!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if result != nil{
            lb_planetName.text = result.name as String
            lb_orbitalPeriod.text = result.orbital_period as String
            lb_gravity.text = result.gravity as String
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
