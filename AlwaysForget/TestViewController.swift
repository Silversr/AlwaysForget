//
//  ViewController.swift
//  AlwaysForget
//
//  Created by User on 6/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import UIKit
import CoreData
var appDelegate = UIApplication.sharedApplication().delegate
class TestViewController: UIViewController {

    let appDelegateInVC:AppDelegate! = appDelegate as? AppDelegate
    var item:NSManagedObject?
    var scene:NSManagedObject?
    var test:TestMO?
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.newScene(localIdentifier: "Scene1ID")
        //self.newItem(localIdentifier: "Item1ID")
        self.fetchItem()
        //self.newTest(name: "someTest")
    }
    func newTest(#name:String){
        self.test = NSEntityDescription.insertNewObjectForEntityForName("Test", inManagedObjectContext: self.appDelegateInVC.managedObjectContext!) as? TestMO
        self.test?.name = name
        self.appDelegateInVC.saveContext()
    }
    func fetchItem(){
        let request:NSFetchRequest = NSFetchRequest(entityName: "Item")
        let results = self.appDelegateInVC.managedObjectContext!.executeFetchRequest(request, error: nil)
        SZLOG(results?.count)
        SZLOG(results?.first?.valueForKey("positionX"))
        let _scene:NSManagedObject = results?.first?.valueForKey("containerScene") as! NSManagedObject
        SZLOG(_scene.valueForKey("localIdentifier"))
    }
    func newScene(localIdentifier ID:String){
        self.scene = NSEntityDescription.insertNewObjectForEntityForName("Scene", inManagedObjectContext: self.appDelegateInVC.managedObjectContext!) as? NSManagedObject
        let now = NSDate()
        self.scene?.setValue(now, forKey: "creationDate")
        self.scene?.setValue(ID, forKey: "localIdentifier")
    }
    func newItem(localIdentifier ID:String){
        self.item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: self.appDelegateInVC.managedObjectContext!) as? NSManagedObject
        let now = NSDate()
        self.item!.setValue(now, forKey: "creationDate")
        self.item!.setValue(10, forKey: "positionX")
        self.item!.setValue(10, forKey: "positionY")
        self.item!.setValue(ID, forKey: "localIdentifier")
        self.item!.setValue(20, forKey: "frameWidthInScene")
        self.item!.setValue(24, forKey: "frameHeightInScene")
        self.item!.setValue(self.scene, forKey: "containerScene")
        self.appDelegateInVC.saveContext()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

