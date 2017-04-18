//
//  PostService.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 15..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//
import UIKit
import CoreLocation

import Firebase

enum FireBaseResponse {
  case success
  case failure(String)
}

struct PostService {
  
  // TODO: create
  
  static func create(
    placeName: String,
    content: String,
    coords: CLLocationCoordinate2D,
    completion: @escaping (FireBaseResponse) -> Void
  ) {
    let ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    let username = "yenafirst91@gmail.com"
    let timestamp = "\(Date(timeIntervalSince1970: Date().timeIntervalSince1970))"
    let content = content
    let coords: [String: Double] = ["latitude": coords.latitude, "longitude": coords.longitude]
    
    let post = Post(placeName: placeName, content: content, username: username, coords: coords, timestamp: timestamp, completed: true)
    
    ref.child("posts").childByAutoId().setValue(post.toAnyObject())
    
    completion(.success)
  }
  
  
  // TODO: list
}
