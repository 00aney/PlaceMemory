//
//  PostCardCell.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 16..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class PostCardCell: UICollectionViewCell {
  
  // MARK: UI
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
//  class func size() -> CGSize {
//    
//  }
  
  
  // MARK: Configuring
  
  func configure(post: Post) {
    self.titleLabel.text = post.placeName
    self.contentLabel.text = post.content
    if let latitude = post.coords["latitude"],
      let longitude = post.coords["longitude"] {
      self.locationLabel.text = "\(round(latitude)), \(round(longitude))"
    }
    
  }
}
