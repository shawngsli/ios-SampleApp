//
//  LabelDetailViewController.swift
//  SampleApp
//
//  Created by  dlc-it on 2019/3/26.
//  Copyright © 2019 shawnli. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    @IBOutlet weak var animalDescription: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    var animal: Animal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = self.animal.name
        self.animalDescription.text = self.animal.description

        if let imageUrl = URL(string: self.animal.imageUrl) {
            ApiRequest.shared.get(imageUrl) { url in
                if let data = try? Data(contentsOf: url) {
                    self.animalImage.image = UIImage(data: data)
                }
            }
        }
    }
}
