//
//  MusicListViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 16.08.2022.
//

import UIKit

class MusicAlbumCell: UITableViewCell {
    @IBOutlet weak var logoAlbum: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var countSongsLabel: UILabel!
}

extension MusicAlbumCell {
    func config() {
        
    }
}

class MusicListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavbar()
    }

}

extension MusicListViewController {
    private func setupNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .profileImage, style: .done, target: nil, action: #selector(profileButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .exitImage, style: .done, target: nil, action: #selector(exitButtonPressed))
    }
    
    @objc private func profileButtonPressed() {
        
    }
    
    @objc private func exitButtonPressed() {
        
    }
}


extension MusicListViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    //MARK: - UITableViewDelegate

}


