//
//  PostsViewController.swift
//  AssessmentTechiebutler
//
//  Created by Bunty Kumar on 03/05/24.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var posts: [Post] = []
    private var currentPage = 1
    private let itemsPerPage = 10
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        Task {
            do {
                try await fetchPosts()
            } catch {
                print("Failed to fetch posts:", error)
                // Handle error
            }
        }
    }
    
    private func fetchPosts() async throws {
        guard !isLoading else { return }
        isLoading = true
        
        let startTime = DispatchTime.now()
        
        let fetchedPosts = try await APIManager.shared.fetchPosts(page: currentPage, limit: itemsPerPage)
        
        
        // Optimize heavy computation for fetched posts
        let optimizedPosts = optimizeHeavyComputation(for: fetchedPosts)
        
        let endTime = DispatchTime.now()
        let elapsedTime = Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000 // Calculate elapsed time in seconds
        print("Time taken for fetching posts: \(elapsedTime) seconds")
        
        posts.append(contentsOf: optimizedPosts)
        isLoading = false
        tableView.reloadData()
    }
    private func optimizeHeavyComputation(for posts: [Post]) -> [Post] {
        // Algorithm optimization can be implemented here
        return posts
    }
    
}


extension PostsViewController : UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        if let id = post.id {
            cell.idLabel.text = "ID: \(id)"
        }
        if let title = post.title {
            cell.titleLabel.text = "Title: \(title)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            currentPage += 1
            Task {
                do {
                    try await fetchPosts()
                } catch {
                    print("Failed to fetch more posts:", error)
                    // Error can be handled here through an alert or retry or a retry button as per requirement
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        
        let startTime = DispatchTime.now()
        
        let optimizedPost = optimizeHeavyComputation(for: [selectedPost]).first!
        
        let endTime = DispatchTime.now()
        let elapsedTime = Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000 // Calculate elapsed time in seconds
        print("Time taken for heavy computation for selected post: \(elapsedTime) seconds")
        
        performSegue(withIdentifier: "ShowPostDetailSegue", sender: optimizedPost)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPostDetailSegue", let selectedPost = sender as? Post {
            let postDetailViewController = segue.destination as! PostDetailViewController
            postDetailViewController.post = selectedPost
        }
    }
}
