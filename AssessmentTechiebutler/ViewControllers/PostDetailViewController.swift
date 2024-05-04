//
//  PostDetailViewController.swift
//  AssessmentTechiebutler
//
//  Created by Bunty Kumar on 03/05/24.
//

import UIKit

class PostDetailViewController: UIViewController {
    var post: Post?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let post = post, let id = post.id {
            idLabel.text = "ID: \(id)"
        }else {
            idLabel.text = ""
        }
        if let post = post, let title = post.title {
            titleLabel.text = "Title: \(title)"
        }else {
            titleLabel.text = ""
        }
        if let post = post, let body = post.body {
            bodyLabel.text = "Body: \(body)"
        }else {
            bodyLabel.text = ""
        }
        if let post = post, let userId = post.userId {
            userIdLabel.text = "UserId: \(userId)"
        }else {
            userIdLabel.text = ""
        }
    }
}
