//
//  ViewController.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tb_listView: UITableView!
    
    var httpService:HTTPService!
    
    var results: [Result_] = []
    
    var planet : Planets? {
        didSet{
            if planet != nil {
                if !(planet?.result.isEmpty)!{
                    results += planet!.result
                    tb_listView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title
        self.title = "Planets"
        
        //TableView nib register
        tb_listView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        
        /// Service class initialize
        httpService = HTTPService(baseURL: HTTPService.url)
        httpService.getPlanetsList(contextPath: HTTPService.apiPath_planets as NSString, pagination: false)
        httpService.planetDataAPIDelegate = self
        
    }
    
    /// This function create a footer view with contain a spinner view
    /// - Returns: Footer view contain with spinner
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    
    /// Remove footer view after load the data
    private func removeFooterView(){
        if self.tb_listView.tableFooterView != nil {
            self.tb_listView.tableFooterView = nil
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tb_listView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as? ListViewCell
        cell?.lb_planetName.text = results[indexPath.row].name as String
        cell?.lb_climate.text    = results[indexPath.row].climate as String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /// Move to the detail view
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        nextViewController.result = results[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated:false)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tb_listView.contentSize.height - 100 - scrollView.frame.size.height) {
            guard !httpService.isPaginating else {
                //Already feching data
                return
            }
            if planet != nil {
                
                guard planet?.next != "" else {
                    //End of the paginantion
                    return
                }
                
                //Set custom footer view into tableview footer
                self.tb_listView.tableFooterView = createSpinnerFooter()
                
                httpService = HTTPService(baseURL: planet?.next)
                httpService.getPlanetsList(contextPath:"", pagination: true)
                httpService.planetDataAPIDelegate = self
            }
        }
    }
    
}


extension MainViewController: PlanetDataAPIDelegate {
    func getPlanetList(response: Planets) {
        planet = response
        removeFooterView()
    }
    
    func getPlanetList(_ error: Error) {
        removeFooterView()
    }
    
    
}
