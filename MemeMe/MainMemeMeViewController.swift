//
//  ViewController.swift
//  MemeMe
//
//  Created by Fatima ALjaber on 11/7/18.
//  Copyright © 2018 Fatima ALjaber. All rights reserved.
//

import UIKit

class MainMemeMeViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var enableCancelButton = true
    var meme : Meme!
    var editingMeme = false
    
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSAttributedStringKey.strokeWidth.rawValue: -4.0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"

        textFieldStyle(topTextField)
        textFieldStyle(bottomTextField)
        shareButton.isEnabled = false
        cancelButton.isEnabled = enableCancelButton
        if editingMeme {
            imagePickerView.image = meme.originalImage
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            shareButton.isEnabled = true
        }
    }
 
    
    func textFieldStyle(_ textField: UITextField){
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center

    }
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)}
    
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        if (bottomTextField.isEditing){
            view.frame.origin.y -= getKeyboardHeight(notification)}
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        imagePicker(source:.photoLibrary)

    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagePicker(source:.camera)
    }
    func imagePicker(source: UIImagePickerControllerSourceType){
        let imagePicked = UIImagePickerController()
        imagePicked.delegate = self
        imagePicked.sourceType = source
        present(imagePicked, animated: true, completion: nil)
        
    }
     func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String: Any]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = pickedImage
            shareButton.isEnabled = true

        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        print("TextField did begin editing method called")
        if (topTextField.isEditing){
            topTextField.text = nil}
        else if (bottomTextField.isEditing){
            bottomTextField.text = nil}
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        return true
    }
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        performSegue(withIdentifier: "memeSaved", sender: AnyObject.self)
    }

    func generateMemedImage() -> UIImage {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.toolBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.toolBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        return memedImage
    }
    @IBAction func shareButton(_ sender: Any) {
       
        let memeImage =  generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        present(activityViewController, animated: true)
        
        activityViewController.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.save()
                print("Image has Saved")
            }
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

