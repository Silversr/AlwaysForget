//
//  HomeViewController.swift
//  AlwaysForget
//
//  Created by User on 6/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UISearchBarDelegate {

    //MARK: Properties
    
    @IBOutlet var searchBar: UISearchBar!
    //MARK: Init and Deinit
    required init(coder aDecoder: NSCoder) {
        //Do any init setup here
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    //MARK: UISearchBar and delegate
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //SZLOG("")
        //searchBarOutlet.e
        self.view.becomeFirstResponder()
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        searchBar.resignFirstResponder()
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        SZLOG("did end end editing")
        //self.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        SZLOG("did begin editing")
    }
    
    //MARK: UIStoryBoardActions
    
    //MARK: UIViewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchBar.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
