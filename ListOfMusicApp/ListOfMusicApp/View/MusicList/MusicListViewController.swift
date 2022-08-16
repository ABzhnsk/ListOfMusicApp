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
    
    var presenter: MusicListPresenter!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavbar()
        presenter = MusicListPresenter(view: self, auth: Authentication())
    }

}

extension MusicListViewController {
    private func setupNavbar() {
        self.navigationController?.navigationBar.tintColor = .purpureColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .profileImage, style: .done, target: self, action: #selector(profileButtonPressed(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .exitImage, style: .done, target: self, action: #selector(exitButtonPressed))
    }
    
    @objc private func profileButtonPressed(_ sender: UIBarButtonItem) {
        presenter.tapProfileButton()
    }
    
    @objc private func exitButtonPressed() {
        presenter.tapExitButton()
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

extension MusicListViewController: MusicListViewProtocol {
    func move(to: MusicListViewNavigation) {
        switch to {
        case .profile:
            let profileVC =  UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            self.navigationController?.pushViewController(profileVC!, animated: true)
        case .exit:
            dismiss(animated: true, completion: nil)
        }
    }
    
    func showLogoutErrorDialog(message: String) {
        AlertBuilder()
            .title("Error")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }
}

