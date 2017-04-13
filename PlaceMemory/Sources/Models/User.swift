//
//  User.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 14..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import FirebaseAuth

struct User {
  
  let uid: String
  let email: String
  
  init(authData: FIRUser) {
    uid = authData.uid
    email = authData.email!
  }
  
  init(uid: String, email: String) {
    self.uid = uid
    self.email = email
  }
  
}

