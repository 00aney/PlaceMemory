//
//  PlaceListViewController.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 3..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class PlaceListViewController: UIViewController {
  
  // MARK: properties
  
  var ref: FIRDatabaseReference!
//  var messages: [FIRDataSnapshot]! = []
  var refHandle: FIRDatabaseHandle!
  
  var posts: [Post] = []
  
  
  // MARK: UI
  
  @IBOutlet var collectionView: UICollectionView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleLabel = UILabel()
    titleLabel.font = UIFont(name: "IowanOldStyle-BoldItalic", size: 20)
    titleLabel.text = "Place Memory"
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
//    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
//    self.collectionView.register(PostCardCell.self, forCellWithReuseIdentifier: "postCardCellId")
    
    // TODO: Load Post List
    self.configureDatabase()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: Firebase
  
  func configureDatabase() {
    ref = FIRDatabase.database().reference()
    
    guard let userID = FIRAuth.auth()?.currentUser?.email else { return }
    print(userID)
    
    ref.child("posts").queryOrdered(byChild: "username")
      .queryEqual(toValue: userID)
      .observe(.value, with: { [weak self] snapshot in
        guard let `self` = self else { return }
        print(snapshot.value)
        
//        guard let message = messageSnapshot.value as? [String:String] else { return }
      })
      
    
      
      
//      
//      .observeSingleEvent(of: .value, with: { snapshot in
//        print(snapshot.value)
//      })
    
    
//    (of: .value, with: { snapshot in
//        print(snapshot)
//      })
    
//    ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//      // Get user value
//      let username = snapshot.value!["username"] as! String
//      let user = User.init(username: username)
//      
//      // ...
//    }) { (error) in
//      print(error.localizedDescription)
//    }
    
    //.child(getUid())).queryOrderedByChild("starCount"
    
//    ref.child("posts").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//      // Get user value
//      let username = snapshot.value!["username"] as! String
//      let user = User.init(username: username)
//      
//      // ...
//    }) { (error) in
//      print(error.localizedDescription)
//    }
  }

}


// MARK: - UICollectionViewDataSource

extension PlaceListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCardCellId", for: indexPath) as! PostCardCell
    
//    cell.configure(post: self.posts[indexPath.item])

    return cell
  }
  
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PlaceListViewController: UICollectionViewDelegateFlowLayout {
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width: self.view.frame.size.width, height: 300)
//  }
  
}
