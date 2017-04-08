//
//  ViewController.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 2..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .gray
    
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().delegate = self
    self.setupGoogleButton()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: setup
  
  fileprivate func setupGoogleButton() {
    let googleButton = GIDSignInButton()
    googleButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
    self.view.addSubview(googleButton)
  }
}


// MARK: - GIDSignInUIDelegate

extension LoginViewController: GIDSignInUIDelegate {
  
}


// MARK: -GIDSignInDelegate

extension LoginViewController: GIDSignInDelegate {
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    
    if let error = error {
      print("Failed to log into Google: \(error)")
    }
    
    if let user = user {
      print("Successfully logged into Google \(user)")
      
      guard let idToken = user.authentication.idToken else { return }
      guard let accessToken = user.authentication.accessToken else { return }
      
      let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
      FIRAuth.auth()?.signIn(with: credentials, completion: { user, error in
        if let error = error {
          print("Failed to create Firebase User with Google account", error)
        }
        guard let uid = user?.uid else { return }
        print("Successfully create a Firebase User with Google", uid)
        
//        self.performSegue(withIdentifier: "ToMain", sender: self)
        AppDelegate.instance?.presentMainScreen()
      })
    }
  }
  
}
