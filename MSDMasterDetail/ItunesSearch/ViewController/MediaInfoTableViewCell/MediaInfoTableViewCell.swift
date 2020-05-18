//
//  MediaInfoTableViewCell.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/16/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import UIKit
import SDWebImage

class MediaInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMedia: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var viewModel: ItunesMediaInfoViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configure(with viewModel: ItunesMediaInfoViewModel) {
        self.viewModel = viewModel
        
        updateView()
    }
    
    func updateView() {
        
        lblTitle.text = viewModel?.name
        
        imgMedia.sd_setImage(with: viewModel?.imageUrl, placeholderImage: UIImage(named: "imagePlaceholder"))
        
        lblGenre.text = viewModel?.genre
        lblPrice.text = viewModel?.price
    }
}
