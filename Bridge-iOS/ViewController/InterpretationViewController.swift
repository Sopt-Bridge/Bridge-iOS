//
//  InterpretationViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 5..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class InterpretationViewController: UIViewController {

    @IBOutlet weak var requestTableView: UITableView!
    @IBOutlet weak var interactionButton: UIRoundButton!
    @IBOutlet weak var searchBar: UIRoundSearchBar!
    
    var requestList: [RequestData] = []
    var searchedRequestList: [RequestData] = []
    var isSearching: Bool = false
    
    func loadRequestList() {
        RequestService.getRequestList { (datas) in
            let currentDateFormatter = DateFormatter()
            currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            let changedDateFormatter = DateFormatter()
            changedDateFormatter.dateFormat = "MM/dd/yyyy"
            
            self.requestList = datas
            for i in 0 ..< self.requestList.count {
                
                if let boardDate = self.requestList[i].iboardDate {
                    if let date = currentDateFormatter.date(from: boardDate){
                        self.requestList[i].iboardDate = changedDateFormatter.string(from: date)
                    }
                }
            }
            
            self.requestTableView.reloadData()
        }
    }
    
    @IBAction func didClickedInteractionButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Write" {
            self.showDetailToWriteViewController()
        }
        else {
            self.doSearch()
        }
    }
    
    func showDetailToWriteViewController() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WriteInterpretationViewController") as? WriteInterpretationViewController
        {
            self.show(vc, sender: nil)
        }
    }
    
    func doSearch() {
        if self.searchBar.text == "" || self.searchBar.text == nil {
            self.isSearching = false
        }
        else {
            self.isSearching = true
            self.searchedRequestList = self.requestList.filter({ (data) -> Bool in
                return data.iboardTitle.range(of: searchBar.text!, options: .caseInsensitive) != nil
            })
        }
        self.searchBar.resignFirstResponder()
        self.requestTableView.reloadData()
    }
    
    func showDetailToDetailInterpretationView(data: RequestData) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailInterpretationViewController") as? DetailInterpretationViewController
        {
            vc.requestData = data
            self.showDetailViewController(vc, sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
            navigationController.navigationBar.layer.shadowOpacity = 0
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.loadRequestList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension InterpretationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.searchedRequestList.count
        }
        return self.requestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UIRequestTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InterpretationCell", for: indexPath) as! UIRequestTableViewCell
        
        if isSearching {
            cell.requestData = self.searchedRequestList[indexPath.item]
            return cell
        }

        cell.requestData = self.requestList[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetailToDetailInterpretationView(data: self.requestList[indexPath.item])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension InterpretationViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.interactionButton.setTitle("Search", for: .normal)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.interactionButton.setTitle("Write", for: .normal)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.doSearch()
    }
}
