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
  var messages: [FIRDataSnapshot]! = []
  var _refHandle: FIRDatabaseHandle!
  
  
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
    
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    
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

}


// MARK: - UICollectionViewDataSource

extension PlaceListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    
    cell.backgroundColor = .blue
    
    return cell
  }
  
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PlaceListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.size.width, height: 300)
  }
  
}
