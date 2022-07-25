//
//  ThingsDisplayViewController.swift
//  Things
//
//  Created by Teja on 22/07/22.
//

import UIKit

class ThingsDisplayViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var thingLbl: UILabel!
    
    //MARK: - Variables
    var selectedThings: [String] = [String]()
    var filteredThings: [String] = [String]()
    
    
    //MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
    }
    
    // MARK: - Functionality
    private func registerNib() {
        let nib = UINib(nibName: "ThingCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "ThingCell")
        self.tblView.separatorStyle = .none
        self.filteredThings = selectedThings
        self.animatedView.alpha = 0.0
    }
    
    // MARK: - Actions
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

//MARK: - Extensions and Delegates
extension ThingsDisplayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredThings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ThingCell") as! ThingCell
        cell.bgView.backgroundColor = UIColor.orange.withAlphaComponent(1.0 - CGFloat(indexPath.row)/CGFloat(selectedThings.count))
        cell.thingLbl.text = filteredThings[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.1) {
            cell.transform = CGAffineTransform.identity
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, animations: {
            self.animatedView.alpha = 0.2
            self.animatedView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (finished) in
            self.thingLbl.text = self.filteredThings[indexPath.row]
            self.animatedView.alpha = 1.0
            self.animatedView.transform = CGAffineTransform.identity
            self.filteredThings = self.selectedThings.filter{self.filteredThings[indexPath.row] != $0}
            self.tblView.reloadData()
        }
    }
}
