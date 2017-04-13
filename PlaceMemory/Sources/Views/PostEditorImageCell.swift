//
//  PostEditorImageCell.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class PostEditorImageCell: UITableViewCell {
  
  // MARK: UI
  
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var addButton: UIButton!
  
  
  // MARK: Size
  
  class func height(width: CGFloat) -> CGFloat {
    return width // 정사각형
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: Configuring
  
  func configure(image: UIImage?) {
    guard let image = image else {
      self.postImageView.image = nil
      self.postImageView.backgroundColor = .clear
      self.postImageView.isOpaque = false
      return
    }
    self.postImageView.image = image
    self.addButton.isHidden = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  // MARK: Actions
  
  @IBAction func addButtonDidTap(_ sender: Any) {
    // TODO: 카메라 라이브러리
  }
  
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.postImageView.frame = self.contentView.bounds
    self.addButton.center = self.contentView.center
  }
  
}
