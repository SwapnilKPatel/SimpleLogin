//
//  ReviewModel.swift
//  DemoProject(ChoosePicture)
//
//  Created by Ravi Chokshi on 17/06/19.
//  Copyright © 2019 Ravi Chokshi. All rights reserved.
//

import Foundation

struct ReviewTimelineModel : Codable {
    
    var timeline : [ReviewModel]

}
struct ReviewModel : Codable {
    
  /*  "_source": {
    "images": [
    {
    "image": "upload-dc4b0f28ce2c5fb3d51ef27e914eec7a-1559920888.jpeg",
    "date_created": "2019-06-07 15:21:29",
    "store_review_id": 5989489,
    "store_review_image_id": 73323,
    "status": "active"
    }
    ],
    "comments": "I think appleyard London flowers are great- I’ve ordered twice and both have been delivered on time.\r\n\r\nThe only reason I didn’t give 5 stars is because the personal card I wrote (which I put a fair bit of effort in) was not attached to the flowers so my friend didn’t actually know who they were from.",
    "date_created": "2019-06-07 15:21:28",
    "author": "Lauren E",
    "reviewer_desc": "Verified Buyer",
    "rating": 4,
    "source": "Reviews",
    "tags": [],
    "additional_ratings": [],
    "responses": [],
    "type_label": "Company",
    "order_id": "500310730",
    "email": "lauren_nicole_ellis@hotmail.co.uk",
    "_id": "store_review-5989489",
    "significant_text": [],
    "helpful": 0
   },*/
    
      var _source: ReviewSourceModel?
    
}
struct ReviewSourceModel : Codable {
    var images : [ReviewImageModel]?
    var comments :  String!
    var date_created : String?
    var author : String?
    var reviewer_desc :  String?
    var rating : Int?
    var source : String?
    var type_label : String?
    
    var order_id : String?
    var email : String?
    var _id : String?
    var helpful : Int?
    
   
    
}
struct ReviewImageModel : Codable {

    var image : String?
    var date_created : String?
    var store_review_id : Int?
    var store_review_image_id : Int?
    var status : String?
}
