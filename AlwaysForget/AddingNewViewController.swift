//
//  AddingNewViewController.swift
//  AlwaysForget
//
//  Created by User on 6/07/2015.
//  Copyright (c) 2015 Silversr. All rights reserved.
//

import UIKit
import CoreData
//MARK:LocalizedString
private let phtotAcquiringActionSheetTitle = NSLocalizedString("Please choose photo acquiring method",comment: "Photo Acquiring Action Sheet Title")
private let photoAcquiringActionSheetCancelButtonTitle = NSLocalizedString("Cancel",comment: "Photo Acquiring Action Sheet Cancel Button Title")
private let photoAcquiringActionSheetPhotoLibraryButtonTitle = NSLocalizedString("Photo Library",comment: "Photo Acquiring Action Sheet Photo Library Button Title")
private let photoAcquiringActionSheetCameraButtonTitle = NSLocalizedString("Camera",comment: "Photo Acquiring Action Sheet Camera Button Title")
class AddingNewViewController: UIViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //MARK: Properties
    private var item:NSManagedObject?
    private var scene:NSManagedObject?
    
    private var itemOrScene:Bool = false // false = Item, true = Scene
    
    lazy var photoAcquiringActionSheet:UIActionSheet = {
        let actionSheet = UIActionSheet(title: phtotAcquiringActionSheetTitle, delegate: self, cancelButtonTitle: photoAcquiringActionSheetCancelButtonTitle, destructiveButtonTitle: nil)
        actionSheet.addButtonWithTitle(photoAcquiringActionSheetPhotoLibraryButtonTitle)
        actionSheet.addButtonWithTitle(photoAcquiringActionSheetCameraButtonTitle)
        return actionSheet
        }()
    //camera
    lazy var imagePickerControllerFromCamera:UIImagePickerController = {
        let imgPicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imgPicker.sourceType = UIImagePickerControllerSourceType.Camera
            if UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)?.isEmpty == false{
                imgPicker.mediaTypes = [UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)![0]]
                SZLOG(imgPicker.mediaTypes)
                imgPicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                
                //customize camera to generate squire picture
                imgPicker.showsCameraControls = true
                let windowsSize = self.view.window?.bounds
                let squireCameraView = CameraOverlayView(frame: windowsSize!)
                //let squireCameraView = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
                //squireCameraView.backgroundColor = UIColor.yellowColor()
                //squireCameraView.alpha = 0.2
                imgPicker.cameraOverlayView = squireCameraView
            }
        }
        imgPicker.delegate = self
        return imgPicker
    }()
    //photoLibrary
    lazy var imagePickerControllerFromPhotoLibrary:UIImagePickerController = {
        let imgPicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            if UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)?.isEmpty == false{
                imgPicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)!
                SZLOG(imgPicker.mediaTypes)
            }
        }
        imgPicker.delegate = self
        return imgPicker
    }()

    
    
    //MARK: Init and Deinit
    required init(coder aDecoder: NSCoder) {
        //Do any init setup here
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //MARK: UIStoryBoardActions
    @IBAction func addSceneClick(sender: AnyObject) {
        self.showPhotoAcquiringActionSheet()
    }
    //MARK: UIViewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: PhotosPicking and related delegate
    func showPhotoLibrary(){
        presentViewController(self.imagePickerControllerFromPhotoLibrary, animated: true, completion: { () in
            SZLOG("Did show photo library")
        })
    }
    func showCamera(){
        presentViewController(self.imagePickerControllerFromCamera, animated: true, completion: { () in
            SZLOG("Did show Camera")
        })
    }
        //Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        SZLOG("Did finish picking media with info")
        //Info Extraction
        SZLOG(info[UIImagePickerControllerMediaMetadata])
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage] as! UIImage, nil, nil, nil)
        
        //Establish New Item
        if self.itemOrScene {
            
        }
        //Establish New Scene
        else{
            
        }
        
        //Save New Item
        dismissViewControllerAnimated(true, completion: { () in
            SZLOG("Did dismiss photo library controller")
        })
        //image info save
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        SZLOG("Did cancel picking media")
        dismissViewControllerAnimated(true, completion: { () in
            SZLOG("Did dismiss camera controller")
        })
    }
    func addNewItem(){
        self.item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext!) as? NSManagedObject
        let now = NSDate()
        self.item!.setValue(now, forKey: "creationDate")
        self.item!.setValue(10, forKey: "positionX")
        self.item!.setValue(10, forKey: "positionY")
        self.item!.setValue("", forKey: "localIdentifier")
        self.item!.setValue(20, forKey: "frameWidthInScene")
        self.item!.setValue(24, forKey: "frameHeightInScene")
        //newItem!.setValue(self.scene, forKey: "containerScene")
        appDelegate.saveContext()
    }
    func addNewScene(){
        self.scene = NSEntityDescription.insertNewObjectForEntityForName("Scene", inManagedObjectContext: appDelegate.managedObjectContext!) as? NSManagedObject
        let now = NSDate()
        self.scene!.setValue(now, forKey: "creationDate")
        self.scene!.setValue("", forKey: "localIdentifier")
        appDelegate.saveContext()
    }
    
    //MARK: AlertController, AlertAction and related delegate
    func showPhotoAcquiringActionSheet(){
        self.photoAcquiringActionSheet.showInView(self.view)
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int){
        SZLOG("button index = \(buttonIndex)")
        switch buttonIndex{
        case 0: SZLOG("Cancel Button Click")
        case 2: self.showCamera()
        case 1: self.showPhotoLibrary()
        default: SZLOG("Unknown Error")
        }
        SZLOG("Did click button at action sheet")
    }
}
