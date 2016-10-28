//
//  PostCell.swift
//  devslopes-showcase
//
//  Created by Nam-Anh Vu on 25/10/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawRect(rect: CGRect) {
        // create circle
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        
        showcaseImg.clipsToBounds = true
    }
    
    func configureCell(post: Post) {
        self.post = post

        self.descriptionTxt.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
    }
}
