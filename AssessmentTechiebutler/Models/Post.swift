//
//  Post.swift
//  AssessmentTechiebutler
//
//  Created by Bunty Kumar on 03/05/24.
//

import Foundation

struct Post: Codable {
    var id: Int?
    var title: String?
    var body: String? // Placeholder for additional details
    var userId: Int?
    
    init(id: Int?, title: String?, body: String?, userId: Int?) {
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
    }
}
