//
//  PostEditorTitleCell.swift
//  PlaceMemory
//
//  Created by aney on 2017. 4. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class PostEditorTitleCell: UITableViewCell {
  
  // MARK: UI
  
  @IBOutlet weak var titleTextField: UITextField!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // MARK: Configuring
  
  func configure(placeName: String?) {
    guard let placeName = placeName else { return }
    self.titleTextField.text = placeName
  }
  
  // MARK: Size
  class func height() -> CGFloat {
    return CGFloat(40)
  }
  
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.titleTextField.frame = CGRect(
      x: 4,
      y: 4,
      width: self.contentView.bounds.width - 8,
      height: self.contentView.bounds.height - 8
    )
    self.titleTextField.center = self.contentView.center
  }
  
}
