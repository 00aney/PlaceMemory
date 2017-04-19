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

enum FireBaseResponse<T> {
  case success(T)
  case failure(String)
}

struct PostService {
  
  // TODO: create
  
  static func create(
    username: String,
    placeName: String,
    content: String,
    coords: CLLocationCoordinate2D,
    completion: @escaping (FireBaseResponse<Void>) -> Void
  ) {
    let ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    let username = username
    let timestamp = "\(Date(timeIntervalSince1970: Date().timeIntervalSince1970))"
    let content = content
    let coords: [String: Double] = ["latitude": coords.latitude, "longitude": coords.longitude]
    
    let post = Post(placeName: placeName, content: content, username: username, coords: coords, timestamp: timestamp, completed: true)
    
    ref.child("posts").childByAutoId().setValue(post.toAnyObject())
    
    completion(FireBaseResponse.success())
  }
  
  
  // TODO: list
  
  static func postsByUserID(
    userID: String,
    completion: @escaping (FireBaseResponse<[Post]>) -> Void
  ) {
    let ref = FIRDatabase.database().reference()
    
    ref.child("posts")
      .queryOrdered(byChild: "username")
      .queryEqual(toValue: userID)
      .observe(.value, with: { snapshot in
        var posts: [Post] = []
        
        if let snapshots = snapshot.value as? [String: Any] {
          for snap in snapshots {
            
            if var postDict = snap.value as? [String: Any] {
              postDict["key"] = snap.key
              let post = Post(dictionary: postDict)
              posts.append(post)
            }
          }
        }
        let newResponse: FireBaseResponse<[Post]> = FireBaseResponse.success(posts)
        completion(newResponse)
      })
  }
  
  // TODO: Calculate gps list
  
  static func postsByUserLocation(
    userID: String,
    location: CLLocation,
    completion: @escaping (FireBaseResponse<[Post]>) -> Void
    ) {
    let ref = FIRDatabase.database().reference()
    
    ref.child("posts").queryOrdered(byChild: "username")
      .queryEqual(toValue: userID)
      .observe(.value, with: { snapshot in
        var posts: [Post] = []
        
        if let snapshots = snapshot.value as? [String: Any] {
          for snap in snapshots {
            
            if var postDict = snap.value as? [String: Any] {
              postDict["key"] = snap.key
              let post = Post(dictionary: postDict)
              
              if let latitude = post.coords["latitude"],
                let longitude = post.coords["longitude"] {
                let placeLocation = CLLocation(latitude: latitude, longitude: longitude)
                let distanceMeters = location.distance(from: placeLocation)
                if distanceMeters <= 1609 {  // under 1 mile
                  posts.append(post)
                }
              }
            }
          }
        }
        let newResponse: FireBaseResponse<[Post]> = FireBaseResponse.success(posts)
        completion(newResponse)
      })
  }
  
}
