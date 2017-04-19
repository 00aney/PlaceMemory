//
//  PostViewController.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 3..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit
import CoreLocation

import Firebase

class PostViewController: UIViewController {

  // MARK: properties
  
  var locationManager: CLLocationManager = CLLocationManager()
  var location: CLLocation!
  
  var postImage: UIImage?
  var placeName: String?
  var content: String?
  var coords: CLLocationCoordinate2D?
  
  
  // MARK: UI
  
  @IBOutlet var tableView: UITableView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleLabel = UILabel()
    titleLabel.font = UIFont(name: "IowanOldStyle-BoldItalic", size: 20)
    titleLabel.text = "Post"
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.startUpdatingLocation()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(cancelButtonDidTap)
    )
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneButtonDidTap)
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillChangeFrame),
      name: .UIKeyboardWillChangeFrame,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(textFieldTextDidChange),
      name: .UITextFieldTextDidChange,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(textViewTextDidChange),
      name: .UITextViewTextDidChange,
      object: nil
    )
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: Actions
  
  func cancelButtonDidTap() {
    self.dismiss(animated: true, completion: nil)
  }
  
  func doneButtonDidTap() {
    guard let placeName = self.placeName,
      let content = self.content,
      let coords = self.coords else { return }
    
    guard let userID = FIRAuth.auth()?.currentUser?.email else { return }
    
    PostService.create(
      username: userID,
      placeName: placeName,
      content: content,
      coords: coords
    ) { response in
      switch response {
      case .success:
        print("success")
        self.dismiss(animated: true, completion: nil)
        
      case .failure(let error):
        print(error)
        
      }
    }
  }
  
  
  // MARK: Notifications
  
  func keyboardWillChangeFrame(notification: Notification) {
    guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
      let duration =  notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
      else { return }
    
    let keyboardVisibleHeight = UIScreen.main.bounds.height - keyboardFrame.origin.y
    
    UIView.animate(withDuration: duration) {
      self.tableView.contentInset.bottom = keyboardVisibleHeight
      self.tableView.scrollIndicatorInsets.bottom = keyboardVisibleHeight
      
      if keyboardVisibleHeight > 0 {
        let indexPath = IndexPath(row: 2, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
      }
    }
  }
  
  func textFieldTextDidChange(notification: Notification) {
    guard let placeName = notification.userInfo?["placeName"] as? String else { return }
    self.placeName = placeName
  }

  func textViewTextDidChange(notification: Notification) {
    guard let content = notification.userInfo?["content"] as? String else { return }
    self.content = content
  }
  
  
  // MARK: Presenting View Controllers
  
  func presentImagePickerController() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    self.present(imagePickerController, animated: true, completion: nil)
  }
  
}


// MARK: - UITableViewDataSource

extension PostViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "postEditorImageCell", for: indexPath) as! PostEditorImageCell
      cell.configure(image: self.postImage)
      return cell
      
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "postEditorTitleCell", for: indexPath) as! PostEditorTitleCell
      cell.configure(placeName: self.placeName)
      return cell
      
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: "postEditorContentCell", for: indexPath) as! PostEditorContentCell
      cell.configure(content: self.content)
      return cell
      
    default:
      return UITableViewCell()
    }
  }
  
}


// MARK: - UITableViewDelegate

extension PostViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return PostEditorImageCell.height(width: self.tableView.frame.width)
      
    case 1:
      return PostEditorTitleCell.height()
      
    case 2:
      return PostEditorContentCell.height()
      
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      self.presentImagePickerController()
      
    default:
      return
    }
  }
  
}


// MARK: - UIImagePickerControllerDelegate

extension PostViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
    
    // TODO: 1번째 셀 UIImage 지정
    self.postImage = selectedImage
    self.tableView.reloadData()
    
    self.dismiss(animated: true, completion: nil)
  }
  
}


// MARK: - UINavigationControllerDelegate

extension PostViewController: UINavigationControllerDelegate {
  
}


// MARK: - CLLocationManagerDelegate

extension PostViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let userLocation: CLLocation = locations[0]
    self.coords = userLocation.coordinate
  }
  
}
