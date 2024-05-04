//
//  APIManager.swift
//  AssessmentTechiebutler
//
//  Created by Bunty Kumar on 03/05/24.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func fetchPosts(page: Int, limit: Int) async throws -> [Post] {
        let urlString = "\(APIEndpoints.baseURL)\(APIEndpoints.postsEndpoint)?_page=\(page)&_limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
}

