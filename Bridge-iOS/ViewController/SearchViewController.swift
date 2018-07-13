//
//  SearchViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 3..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var hashtagButton: UIButton!
    @IBOutlet weak var searchButtonLine: UIImageView!
    @IBOutlet weak var hashtagButtonLine: UIImageView!
    
    let enableColor: UIColor = UIColor(rgb: 0xE31C9E)
    let disableColor: UIColor = UIColor.lightGray
    
    let searchCellIdentifire: String = "SearchCell"
    let hashtagCellIdentifire: String = "HashtagCell"
    let headerCellIdentifire: String = "headerCell"
    
    @IBAction func didClickedBackButton(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    @IBAction func didClickedSearchButton(_ sender: UIButton) {
        if !self.searchButtonLine.isHidden {
            return
        }
        
        self.searchBar.placeholder = "Search"
        self.searchButton.setTitleColor(self.enableColor, for: .normal)
        self.hashtagButton.setTitleColor(self.disableColor, for: .normal)
        self.searchButtonLine.isHidden = false
        self.hashtagButtonLine.isHidden = true
    }
    
    @IBAction func didClickedHashtagButton(_ sender: UIButton) {
        if !self.hashtagButtonLine.isHidden {
            return
        }
        
        self.searchBar.placeholder = "#Search"
        self.searchButton.setTitleColor(self.disableColor, for: .normal)
        self.hashtagButton.setTitleColor(self.enableColor, for: .normal)
        self.searchButtonLine.isHidden = true
        self.hashtagButtonLine.isHidden = false
    }
    
    func hideNavigationAndTabBar() {
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    
    func showNavigationAndTabBar() {
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationAndTabBar()
        self.present(prepareAlert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showNavigationAndTabBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
