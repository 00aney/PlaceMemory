//
//  MainTabBarController.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 3..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
//    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    // Do any additional setup after loading the view.
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

  func presentPostViewController() {
    guard let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostViewControllerID") else { return }
    
    self.present(UINavigationController(rootViewController: postViewController), animated: true, completion: nil)
  }
  
}

extension MainTabBarController: UITabBarControllerDelegate {
  
  func tabBarController(
    _ tabBarController: UITabBarController,
    shouldSelect viewController: UIViewController
    ) -> Bool {
    if let fakeViewController = tabBarController.viewControllers?[2] as? FakeViewController {
      if viewController === fakeViewController {
        self.presentPostViewController()
        return false
      }
    }
    
    return true
  }
  
}
