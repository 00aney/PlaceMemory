//
//  NearPlaceListViewController.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 19..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit
import CoreLocation

import Firebase

class NearPlaceListViewController: UIViewController {
  
  // MARK: properties
  
  var posts: [Post] = []
  
  var locationManager: CLLocationManager = CLLocationManager()
  var location: CLLocation!
  
  
  // MARK: UI
  
  @IBOutlet var collectionView: UICollectionView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.startUpdatingLocation()
    self.location = locationManager.location
    
    let titleLabel = UILabel()
    titleLabel.font = UIFont(name: "IowanOldStyle-BoldItalic", size: 20)
    titleLabel.text = "Places I Visited"
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    //    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    //    self.collectionView.register(PostCardCell.self, forCellWithReuseIdentifier: "postCardCellId")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.loadPosts()
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
  
  func loadPosts() {
    guard let userID = FIRAuth.auth()?.currentUser?.email,
      let location = self.location else { return }
    
    print("\(userID) : \(location)")
    PostService.postsByUserLocation(
      userID: userID,
      location: self.location) { response in
      switch response {
      case .success(let posts):
        self.posts = posts
        self.collectionView.reloadData()
        
      case .failure(let errorMessage):
        print("\(errorMessage)")
      }
    }
  }
  
}


// MARK: - UICollectionViewDataSource

extension NearPlaceListViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.posts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCardCellId", for: indexPath) as! PostCardCell
    
    cell.configure(post: self.posts[indexPath.item])
    
    return cell
  }
  
}


// MARK: - UICollectionViewDelegateFlowLayout

extension NearPlaceListViewController: UICollectionViewDelegateFlowLayout {
  
  //  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
  //    return CGSize(width: self.view.frame.size.width, height: 300)
  //  }
  
}


// MARK: - CLLocationManagerDelegate

extension NearPlaceListViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let userLocation: CLLocation = locations[0]
    self.location = userLocation
  }
  
}
