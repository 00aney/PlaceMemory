//
//  PostEditorContentCell.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class PostEditorContentCell: UITableViewCell {
  
  // MARK: UI
  
  @IBOutlet weak var contentTextView: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  // MARK: Size
  
  class func height() -> CGFloat {
    return CGFloat(90)
  }
  
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentTextView.frame = CGRect(
      x: 4,
      y: 4,
      width: self.contentView.bounds.width - 8,
      height: self.contentView.bounds.height - 8
    )
    self.contentTextView.center = self.contentView.center
  }
  
}
