//
//  DetailsViewController.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 16.08.2022.
//

import UIKit

class DetailAlbumCell: UITableViewCell {
    @IBOutlet weak var nameSongLabel: UILabel!
}

extension DetailAlbumCell {
    func config(_ song: Song){
        nameSongLabel.text = song.trackName
    }
}


class DetailsViewController: UIViewController {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var logoAlbum: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!
    @IBOutlet weak var countSongsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var albums: Album?
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setData()
        fetchSong(album: albums)
    }
}

extension DetailsViewController {
    private func setData() {
        guard let album = albums else { return }
        
        albumNameLabel.text = album.collectionName
        groupNameLabel.text = "Artist name: \(album.artistName)"
        dateCreateLabel.text = "Date release: \(setDateFormatter(date: album.releaseDate))"
        countSongsLabel.text = "\(album.trackCount) tracks:"
        guard let url = album.artworkUrl100 else { return }
        setLogoAlbum(urlString: url)
        
    }
    
    private func setDateFormatter(date: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyy'-'MM'-'dd'T'HH':'mm':'ssZZZ'"
        
        guard let date = df.date(from: date) else { return "" }
        let formatDate = DateFormatter()
        
        formatDate.dateFormat = "dd.MM.yyyy"
        let releaseDate = formatDate.string(from: date)
        return releaseDate
    }
    
    private func setLogoAlbum(urlString: String?) {
        if let url = urlString {
            NetworkRequest.shared.requestData(urlString: url ) { [ weak self ] result in
                switch result {
                case .success(let data):
                    self?.logoAlbum.image = UIImage(data: data)
                case .failure(let err):
                    self? .logoAlbum.image = nil
                    print("No album logo: ", err.localizedDescription)
                }
            }
        } else {
            logoAlbum.image = nil
        }
    }
    
    private func fetchSong(album: Album?) {
        guard let album = album else { return }
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        NetworkDataFetch.shared.fetchSong(urlString: urlString) { [weak self] song, err in
            if err == nil {
                guard let song = song else { return }
                self?.songs = song.results
                self?.tableView.reloadData()
            } else {
                AlertBuilder()
                    .title("Error")
                    .message(err!.localizedDescription)
                    .action("OK")
                    .show((self)!, animated: true)
            }
        }
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailAlbumCell
        cell.config(songs[indexPath.row])
        return cell
    }
}
