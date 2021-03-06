//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Mayank Kapoor on 9/2/14.
//  Copyright (c) 2014 Mayank Kapoor. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var artistNameLabel: UILabel!
	@IBOutlet weak var artworkImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let image = UIImage(named: "TableCellGradient")
		let backgroundImageView = UIImageView(image: image)
		self.backgroundView = backgroundImageView
		
		let selectedImage = UIImage(named: "SelectedTableCellGradient")
		let selectedBackgroundImageView = UIImageView(image: selectedImage)
		self.selectedBackgroundView = selectedBackgroundImageView
	}
}
