//
//  PhotoInfo.swift
//  PhotoInfo
//
//  Created by Pratham on 18/04/24.

import UIKit

struct PhotoInfo: Codable {
    var title: String
    var description : String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
}
