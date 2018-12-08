//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Fatima ALjaber on 11/22/18.
//  Copyright © 2018 Fatima ALjaber. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var sentMemeImg: UIImageView!
    var meme : Meme!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sentMemeImg!.image = meme.memedImage
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var EditButton: UIBarButtonItem!
    
    @IBAction func EditButton(_ sender: Any) {
        let editMemeViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainMemeMeViewController") as! MainMemeMeViewController
        editMemeViewController.meme = meme
        editMemeViewController.editingMeme = true
        navigationController?.present(editMemeViewController, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
