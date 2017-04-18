//
//  Post.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 14..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Post {
  
  let key: String
  let imageURL: String?
  let placeName: String
  let content: String?
  let username: String
  var coords: [String: Double]
  let timestamp: String
  let ref: FIRDatabaseReference?
  var completed: Bool
  
  init(
    imageURL: String? = nil,
    placeName: String,
    content: String,
    username: String,
    coords: [String: Double],
    timestamp: String,
    completed: Bool,
    key: String = ""
  ) {
    self.key = key
    self.imageURL = imageURL
    self.placeName = placeName
    self.content = content
    self.username = username
    self.coords = coords
    self.timestamp = timestamp
    self.completed = completed
    self.ref = nil
  }
  
  init(snapshot: FIRDataSnapshot) {
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    imageURL = snapshotValue["imageURL"] as? String
    placeName = snapshotValue["placeName"] as! String
    content = snapshotValue["content"] as? String
    username = snapshotValue["username"] as! String
    coords = snapshotValue["coords"] as! [String: Double]
    timestamp = snapshotValue["timestamp"] as! String
    completed = snapshotValue["completed"] as! Bool
    ref = snapshot.ref
  }
  
  init(dictionary: [String: Any]) {
    key = ""
    imageURL = dictionary["imageURL"] as? String
    placeName = dictionary["placeName"] as! String
    content = dictionary["content"] as? String
    username = dictionary["username"] as! String
    coords = dictionary["coords"] as! [String: Double]
    timestamp = dictionary["timestamp"] as! String
    completed = dictionary["completed"] as! Bool
    ref = nil
  }
  
  func toAnyObject() -> Any {
    return [
      "imageURL": imageURL ?? "",
      "placeName": placeName,
      "content": content ?? "",
      "username": username,
      "coords": coords,
      "timestamp": timestamp,
      "completed": completed
    ]
  }
  
}
