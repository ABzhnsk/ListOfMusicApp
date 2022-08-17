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
    func config(_ album: Album) {
        albumNameLabel.text = album.collectionName
        groupNameLabel.text = album.artistName
        countSongsLabel.text = "\(album.trackCount) tracks"
        if let urlString = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlString) { [ weak self ] result in
                switch result {
                case .success(let data):
                    self?.logoAlbum.image = UIImage(data: data)
                case .failure(let err):
                    self?.logoAlbum.image = nil
                    print("No album logo: ", err.localizedDescription)
                }
            }
        } else {
            logoAlbum.image = nil
        }
    }
}

class MusicListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: MusicListPresenter!
    var albums: [Album]?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        setupNavbar()
        presenter = MusicListPresenter(view: self, auth: Authentication(), albums: albums)
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


extension MusicListViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicAlbumCell
        guard let album = self.albums?[indexPath.row] else { return cell }
        cell.config(album)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectRow(at: indexPath.row)
    }
    
    //MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let text = searchText else { preconditionFailure() }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            self?.presenter.didChangeSearch(albumName: text)
        })
    }
}

extension MusicListViewController: MusicListViewProtocol {
    
    func move(to: MusicListViewNavigation) {
        switch to {
        case .profile:
            let profileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            self.navigationController?.pushViewController(profileVC!, animated: true)
        case .details(let album):
            let detailsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            detailsVC?.albums = album
            detailsVC?.title = "Details"
            self.navigationController?.pushViewController(detailsVC!, animated: true)
        case .exit:
            dismiss(animated: true, completion: nil)
        }
    }
    
    func showMusicList(albums: [Album]?) {
        self.albums = albums
        tableView.reloadData()
    }
    
    func getAlbum(at index: Int) -> Album {
        guard let album = self.albums?[index] else { preconditionFailure() }
        return album
    }
    
    func showLogoutErrorDialog(message: String) {
        AlertBuilder()
            .title("Error")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }
    
    func showSearchError() {
        AlertBuilder()
            .title("Error")
            .message("Coudn't found")
            .action("OK")
            .show(self, animated: true)
    }
}


