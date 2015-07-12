//
//  ViewController.swift
//  AlwaysForget
//
//  Created by User on 6/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import UIKit
import CoreData
//var appDelegate = UIApplication.sharedApplication().delegate
class TestViewController: UIViewController {

    let appDelegateInVC:AppDelegate! = appDelegate
    lazy var category:CategoryMO = {
        return NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: appDelegate.managedObjectContext!) as! CategoryMO
    }()
    lazy var item:ItemMO = {
        return NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext!) as! ItemMO
    }()
    lazy var scene:SceneMO = {
        return NSEntityDescription.insertNewObjectForEntityForName("Scene", inManagedObjectContext: appDelegate.managedObjectContext!) as! SceneMO
    }()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //NSEntityDescription.insertNewObjectForEntityForName("Test", inManagedObjectContext: appDelegate.managedObjectContext)
        // Do any additional setup after loading the view, typically from a nib.
        //self.newScene(localID: "Scene 1")
        //self.newItem(localID: "item 1")
        //self.newItem(localID: "item 2")
        //self.addItemToScene(item: self.item, scene: self.scene, positionXInScene: 22.0, positionYInScene: 33.0)
//
//        
//        let scn = self.fetchScene()
//        let itm = self.fetchItem()
//        SZLOG(itm?.positionX)
//        itm?.positionX = 98.2
//        appDelegate.saveContext()
//        let modifiedItm = self.fetchItem()
//        SZLOG(modifiedItm?.positionX)
        //SceneMO.deleteScene(scene: scn!)
        //ItemMO.deleteItem(item: itm!)
        //self.fetchScene()
        //self.fetchItem()
        //ItemMO.fetchItem(localIdentifier: "item 3")
        //self.deleteItem(item: itm!)
        //self.fetchScene()
        //SceneMO.deleteScene(scene: scn!)

    }
    func deleteItem(#item:ItemMO){
        SZLOG(item.localIdentifier)
        appDelegate.managedObjectContext?.deleteObject(item)
        appDelegate.saveContext()
    }
    func addItemToScene(#item:ItemMO,scene:SceneMO,positionXInScene x:Double,positionYInScene y:Double){
        item.positionX = x
        item.positionY = y
        item.containerScene = scene
        appDelegate.saveContext()
    }
    func newItem(#localID:String){
        self.item.creationDate = NSDate()
        self.item.localIdentifier = localID
        //self.item.containerScene = self.scene
        appDelegate.saveContext()
    }
    func fetchItem() -> ItemMO?{
        let attributeID = "localIdentifier"
        let attributePX = "positionX"
        let attributePXBetween = "{1,100}"
        let attributeValue = "item 2"
        let request:NSFetchRequest = NSFetchRequest(entityName: "Item")
        request.predicate = NSPredicate(format: "%K BETWEEN {\(1),\(100)}", argumentArray: [attributePX])
        let results = self.appDelegateInVC.managedObjectContext!.executeFetchRequest(request, error: nil)

        
        SZLOG(results?.count)
        SZLOG((results?.first as? ItemMO)?.localIdentifier)
        SZLOG((results?.first as? ItemMO)?.containerScene.localIdentifier)
        //SZLOG((results?.last as! ItemMO).localIdentifier)
        return results?.first as? ItemMO
    }
    func newScene(#localID:String){
        self.scene.creationDate = NSDate()
        self.scene.localIdentifier = localID
        appDelegate.saveContext()
    }
    func fetchScene() -> SceneMO?{
        let request:NSFetchRequest = NSFetchRequest(entityName: "Scene")
        let results = self.appDelegateInVC.managedObjectContext!.executeFetchRequest(request, error: nil)
        SZLOG(results?.count)
        SZLOG((results?.first as! SceneMO).localIdentifier)
        SZLOG((results?.first as! SceneMO).childItems.first?.localIdentifier)
        return results?.first as? SceneMO
    }
//    func newTest(#name:String){
//        self.test = NSEntityDescription.insertNewObjectForEntityForName("Test", inManagedObjectContext: self.appDelegateInVC.managedObjectContext!) as! TestMO
//        self.test.name = name
//        //self.test?.setValue(name, forKey: "name")
//        self.appDelegateInVC.saveContext()
//    }
//    func fetchTest(){
//        let request:NSFetchRequest = NSFetchRequest(entityName: "Test")
//        let results = self.appDelegateInVC.managedObjectContext!.executeFetchRequest(request, error: nil)
//        SZLOG(results?.count)
//        if results?.last is TestMO{
//            SZLOG("is TestMO")
//        }
//        
//        SZLOG(results!.last!.valueForKey("name"))
//        SZLOG((results!.last as! TestMO).name)
//        
//        //(results!.last as! TestMO).name
//        
//    }
//    func fetchItem(){
//        let request:NSFetchRequest = NSFetchRequest(entityName: "Item")
//        let results = self.appDelegateInVC.managedObjectContext!.executeFetchRequest(request, error: nil)
//        SZLOG(results?.count)
//        SZLOG(results?.first?.valueForKey("positionY"))
//        //let _scene:NSManagedObject = results?.first?.valueForKey("containerScene") as! NSManagedObject
//        //SZLOG(_scene.valueForKey("localIdentifier"))
//    }
//    func newScene(localIdentifier ID:String){
//        self.scene = NSEntityDescription.insertNewObjectForEntityForName("Scene", inManagedObjectContext: self.appDelegateInVC.managedObjectContext!) as! SceneMO
//        let now = NSDate()
//        self.scene.setValue(now, forKey: "creationDate")
//        self.scene.setValue(ID, forKey: "localIdentifier")
//    }
//    func newItem(localIdentifier ID:String){
//        self.item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: self.appDelegateInVC.managedObjectContext!) as! ItemMO
//        let now = NSDate()
//        self.item.setValue(now, forKey: "creationDate")
//        self.item.setValue(10, forKey: "positionX")
//        self.item.setValue(10, forKey: "positionY")
//        self.item.setValue(ID, forKey: "localIdentifier")
//        self.item.setValue(20, forKey: "frameWidthInScene")
//        self.item.setValue(24, forKey: "frameHeightInScene")
//        self.item.setValue(self.scene, forKey: "containerScene")
//        self.appDelegateInVC.saveContext()
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

