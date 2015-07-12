//
//  ManagedObjects.swift
//  AlwaysForget
//
//  Created by User on 6/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import Foundation
import CoreData
//MARK: Item Managed Object -> Item Entity
@objc
class ItemMO:NSManagedObject{
    //MARK: Init And Deinit
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    deinit{
    }
    //MARK: Properties
    @NSManaged var creationDate:NSDate
    @NSManaged var localIdentifier:String
    @NSManaged var detail:String?
    @NSManaged var categoryTag:String?
    @NSManaged var positionX:Double
    @NSManaged var positionY:Double
    @NSManaged var frameWidthInScene:Double
    @NSManaged var frameHeightInScene:Double
    @NSManaged var containerScene:SceneMO
    //MARK: data model creation method with saving
    class func insertNewItem(creationDate date:NSDate,localIdentifier id:String!) -> ItemMO{
        
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext!) as! ItemMO
        item.creationDate = date
        item.localIdentifier = id
        appDelegate.saveContext()
        return item
    }
    //MARK: place item on scene with saving
    class func placeItemOnScene(#item:ItemMO,scene:SceneMO,positionXInScene x:Double,positionYInScene y:Double,itemWidthInScene width:Double,itemHeightInScene height:Double,detail:String?,category:String?){
        item.positionX = x
        item.positionY = y
        item.frameWidthInScene = width
        item.frameHeightInScene = height
        item.containerScene = scene
        item.detail = detail
        item.categoryTag = category
        appDelegate.saveContext()
    }
    //MARK: delete an Item
    class func deleteItem(#item:ItemMO){
        appDelegate.managedObjectContext?.deleteObject(item)
        appDelegate.saveContext()
    }
    //MARK: fetch an Item with localIdentifier
    class func fetchItem(localIdentifier id:String) -> ItemMO?{
        let localIdentifierKey = "localIdentifier"
        let request:NSFetchRequest = NSFetchRequest(entityName: "Item")
        request.predicate = NSPredicate(format: "%K Like %@", argumentArray: [localIdentifierKey,id])
        let result = appDelegate.managedObjectContext!.executeFetchRequest(request, error: nil)
        SZLOG((result?.first as? ItemMO)?.localIdentifier)
        return result?.first as? ItemMO
    }
    class func fetchItems(categoryTag cat:String) ->[ItemMO]?{
        let categoryTagKey = "categoryTag"
        let request:NSFetchRequest = NSFetchRequest(entityName: "Item")
        request.predicate = NSPredicate(format: "%K Like %@", argumentArray: [categoryTagKey,cat])
        let results = appDelegate.managedObjectContext!.executeFetchRequest(request, error: nil)
        SZLOG((results as? [ItemMO])?.count)
        return results as? [ItemMO]
    }
}

//MARK: Scene Managed Object -> Scene Entity
@objc
class SceneMO:NSManagedObject {
    //MARK: Init And Deinit
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    deinit{
    }
    //MARK: Properties
    @NSManaged var creationDate:NSDate
    @NSManaged var room:String?
    @NSManaged var localIdentifier:String
    @NSManaged var childItems:Set<ItemMO>
    //MARK: data model creation method with saving
    class func insertNewScene(creationDate date:NSDate,localIdentifier id:String!) -> SceneMO{
        let scene = NSEntityDescription.insertNewObjectForEntityForName("Scene", inManagedObjectContext: appDelegate.managedObjectContext!) as! SceneMO
        scene.creationDate = date
        scene.localIdentifier = id
        return scene
    }
    //MARK: delete a Scene
    class func deleteScene(#scene:SceneMO){
        appDelegate.managedObjectContext?.deleteObject(scene)
        appDelegate.saveContext()
    }
    //MARK: fetch an Scene with localIdentifier
    class func fetchScene(localIdentifier id:String) -> SceneMO?{
        let localIdentifierKey = "localIdentifier"
        let request:NSFetchRequest = NSFetchRequest(entityName: "Scene")
        request.predicate = NSPredicate(format: "%K Like %@", argumentArray: [localIdentifierKey,id])
        let result = appDelegate.managedObjectContext!.executeFetchRequest(request, error: nil)
        SZLOG((result?.first as? SceneMO)?.localIdentifier)
        return result?.first as? SceneMO
    }
}

//MARK: Category Managed Object -> Category Entity
@objc
class CategoryMO:NSManagedObject{
    //MARK: Init And Deinit
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    deinit{
    }
    //MARK: Properties
    @NSManaged var name:String
    //MARK: data model creation method with saving
    class func insertNewCategory(categoryName name:String) -> CategoryMO{
        let category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: appDelegate.managedObjectContext!) as! CategoryMO
        category.name = name
            return category
    }
    //MARK: delete a Category
    class func deleteCategory(#category:CategoryMO){
        appDelegate.managedObjectContext?.deleteObject(category)
        appDelegate.saveContext()
    }
    //MARK: fetch Categories
    class func fetchCategories() ->[CategoryMO]?{
        let request:NSFetchRequest = NSFetchRequest(entityName: "Category")
        let results = appDelegate.managedObjectContext!.executeFetchRequest(request, error: nil)
        SZLOG((results as? [CategoryMO])?.count)
        return results as? [CategoryMO]
    }
}
