//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Fatima ALjaber on 11/21/18.
//  Copyright © 2018 Fatima ALjaber. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
 
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCellInTable", for: indexPath) as! MemeTableViewCell
        let MemeImg = memes[indexPath.row].memedImage

        cell.sentMemeImg?.image = MemeImg
        cell.memeTextLabel?.text = memes[indexPath.row].topText + "   " + memes[indexPath.row].bottomText

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "memeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }


   
}
