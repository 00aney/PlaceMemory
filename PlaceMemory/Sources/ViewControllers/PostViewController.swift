//
//  PostViewController.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 3..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class PostViewController: UIViewController {

  // MARK: properties
  
  var ref: FIRDatabaseReference!
  var posts: [FIRDataSnapshot]! = []
  var _refHandle: FIRDatabaseHandle!
  
  var postImage: UIImage?
  var placeName: String?
  var content: String?
  
  
  // MARK: UI
  
  @IBOutlet var tableView: UITableView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
//    self.tableView.register(PostEditorImageCell.self, forCellReuseIdentifier: "PostEditorImageCell")
//    self.tableView.register(PostEditorTitleCell.self, forCellReuseIdentifier: "PostEditorTitleCell")
//    self.tableView.register(PostEditorContentCell.self, forCellReuseIdentifier: "PostEditorContentCell")
    
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
    
    self.configureDatabase()
//    self.buttonDidTap()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: Firebase
  
  func configureDatabase() {
    ref = FIRDatabase.database().reference()
    //     Listen for new messages in the Firebase database
//    _refHandle = self.ref.child("posts").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
//      guard let `self` = self else { return }
//      self.posts.append(snapshot)
//    })
  }
  
  func buttonDidTap() {
    var mdata = [String: Any]()
    mdata["title"] = "test"
    mdata["username"] = "yenafirst91"
    mdata["content"] = "test"
    mdata["coords"] = ["latitude": 12, "longtitude": 13]
    mdata["timestamp"] = "\(Date(timeIntervalSince1970: Date().timeIntervalSince1970))"
    
    self.ref.child("posts").childByAutoId().setValue(mdata)
    
  }
  
  func cancelButtonDidTap() {
    print("cancelButtonDidTap")
    self.postImage = nil
    self.placeName = ""
    self.content = ""
    self.tableView.reloadData()
  }
  
  func doneButtonDidTap() {
    print("doneButtonDidTap")
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
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
