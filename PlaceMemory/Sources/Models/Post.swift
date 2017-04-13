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
  let imageURL: String
  let placeName: String
  let content: String
  let username: String
  var coords: CGPoint = CGPoint(x: 0, y: 0)
  let ref: FIRDatabaseReference?
  var completed: Bool
  
  init(imageURL: String, placeName: String, content: String, username: String, coords: CGPoint, completed: Bool, key: String = "") {
    self.key = key
    self.imageURL = imageURL
    self.placeName = placeName
    self.content = content
    self.username = username
    self.coords = coords
    self.completed = completed
    self.ref = nil
  }
  
  init(snapshot: FIRDataSnapshot) {
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    imageURL = snapshotValue["imageURL"] as! String
    placeName = snapshotValue["placeName"] as! String
    content = snapshotValue["content"] as! String
    username = snapshotValue["username"] as! String
    coords.x = snapshotValue["coords"]?["latitude"] as! CGFloat
    coords.y = snapshotValue["coords"]?["longtitude"] as! CGFloat
    completed = snapshotValue["completed"] as! Bool
    ref = snapshot.ref
  }
  
  func toAnyObject() -> Any {
    return [
      "imageURL": imageURL,
      "placeName": placeName,
      "content": content,
      "username": username,
      "coords/latitude": coords.x,
      "coords/longtitude": coords.y,
      "completed": completed
    ]
  }
  
}
