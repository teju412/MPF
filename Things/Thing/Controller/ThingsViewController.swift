//
//  ThingsViewController.swift
//  Things
//
//  Created by Teja on 22/07/22.
//

import UIKit

class ThingsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nextBtnOL: UIButton!
    
    //MARK: - Variables/ Objects
    var getThingsUrl = "https://mocki.io/v1/27c04b02-a566-4fc9-a4cb-70f7c5b8619d"
    var things: [Thing] = [Thing]()
    lazy var selectedRows: [Int] = [Int]()
    
    //MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.setup()
        self.getThings()
    }
    
    //MARK: - Functionality
    private func registerNib() {
        let nib = UINib(nibName: "ThingCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "ThingCell")
        self.tblView.separatorStyle = .none
        self.tblView.allowsMultipleSelection = true
    }
    private func setup() {
        self.nextBtnOL.isEnabled = false
    }
    
    //MARK: - Api Calls
    
    /// Description : - get the things
    private func getThings() {
        APIManager.fetch(url: getThingsUrl) { (result: Result<[Thing], NetworkRequestError>) in
            switch result {
            case .success(let success):
                self.things = success
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedString)
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func nextBtn(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ThingsDisplayViewController") as! ThingsDisplayViewController
        vc.selectedThings = self.selectedRows.map{things[$0].name}
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

//MARK: - Extensions and Delegates
extension ThingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ThingCell") as! ThingCell
        cell.bgView.backgroundColor = UIColor.orange.withAlphaComponent(1.0 - CGFloat(indexPath.row)/CGFloat(things.count))
        cell.thingLbl.text = self.things[indexPath.row].name ?? ""
        cell.isDisplayImage = true
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 1.0) {
            cell.transform = CGAffineTransform.identity
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectedRows.contains(indexPath.row){
            self.selectedRows.append(indexPath.row)
        }
        print(selectedRows)
        self.nextBtnOL.isEnabled = selectedRows.count >= 3
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = selectedRows.firstIndex(of: indexPath.row){
            selectedRows.remove(at: index)
        }
        print(selectedRows)
    }
}
