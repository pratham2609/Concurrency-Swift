//
//  ViewController.swift
//  PhotoInfo
//
//  Created by Pratham on 18/04/24.
//

import UIKit

class ViewController: UIViewController {
    let photoInfoController = PhotoInfoController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    func updateUI(with photoInfo: PhotoInfo) async throws {
        let image = try await photoInfoController.fetchImage(from: photoInfo.url)
        self.title = photoInfo.title
        self.imageView.image = image
        self.descriptionLabel.text = photoInfo.description
        self.copyrightLabel.text = photoInfo.copyright
    }
    
    func updateUI(with error: Error) {
        self.title = "Can not fetch data"
        imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        self.descriptionLabel.text = "Can not fetch data"
        self.copyrightLabel.text = "Can not fetch data"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = ""
        imageView.image = UIImage(systemName: "photo.on.rectangle.angled")!
        self.descriptionLabel.text = ""
        self.copyrightLabel.text = ""
        
        // data is not fetched
        Task {
            do {
                let photoInfo = try await photoInfoController.fetchData()
                try await updateUI(with: photoInfo)
            } catch {
                updateUI(with: error)
            }
        }
    }
}

