//
//  Post.swift
//  devslopes-showcase
//
//  Created by Nam-Anh Vu on 27/10/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import Foundation

class Post {
    private var _postDescription: String! //! = required
    private var _imageURL: String? // option, so a user doesn't have to post an image
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    
    var postDescription: String {
        return _postDescription
    }
    
    var imageURL: String? {
        return _imageURL
    }
    
    var likes: Int {
        return _likes
    }
    
    var username: String {
        return _username
    }
    
    // for new posts
    init(pDescription: String, imageUrl: String?, username: String) {
        self._postDescription = pDescription
        self._imageURL = imageUrl
        self._username = username
    }
    
    // initialiser we use whenever we download data to Firebase
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        // dictionaries don't guarantee values so we have to use if lets
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imgUrl = dictionary["imageURL"] as? String {
            self._imageURL = imgUrl
        }
        
        if let desc = dictionary["description"] as? String {
            self._postDescription = desc
        }
    }
}
