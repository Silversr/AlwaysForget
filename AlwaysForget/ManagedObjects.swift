//
//  ItemMO.swift
//  AlwaysForget
//
//  Created by User on 6/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import Foundation
import CoreData
//MARK: Item Managed Object -> Item Entity
class ItemMO:NSManagedObject{
    //MARK: Init And Deinit
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    deinit{
    }
    //MARK: Properties
    private let creationDate = NSDate()
    var localIdentifier:String = "abcdefg" // should be let
    
    
}
//MARK: Scene Managed Object -> Scene Entity
class SceneMO:NSManagedObject {
    //MARK: Init And Deinit
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    deinit{
    }
    //MARK: Properties
    
}
//MARK: Category Managed Object -> Category Entity
class Category:NSManagedObject{
    //MARK: Init And Deinit
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    deinit{
    }
    //MARK: Properties
}
//MARK: Test Managed Object -> Test Entity Tesing
class TestMO:NSManagedObject{
    //MARK: Init And Deinit
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    deinit{
    }
    //MARK: Properties
    var name:String?
}