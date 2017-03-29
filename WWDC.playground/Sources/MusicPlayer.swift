import Foundation
import UIKit
import AVFoundation

open class MusicPlayer: UIView {
    let songTable = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    var results = [Track]()
    var player: AVQueuePlayer!
    
    let baseUrl = "https://api.spotify.com/v1/search?"
    let baseTrackUrl = "https://api.spotify.com/v1/artists"
    let reuseId = "trackCell"
    var currArtistId = ""
    
    public init(frame: CGRect, player: AVQueuePlayer) {
        super.init(frame: frame)
        self.player = player
        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        songTable.tableHeaderView = searchController.searchBar
//        searchController.searchBar.becomeFirstResponder()
        
        songTable.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        songTable.delegate = self
        songTable.dataSource = self
        songTable.frame = frame
        addSubview(songTable)
        
        getNewResults()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getNewResults(artist: String = "Lorde") {
        let fetchUrl = "\(baseUrl)q=$\(artist)&type=artist&limit=1"
        let url = URL(string: fetchUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                if let artists = json["artists"] as? [String: AnyObject], let item = artists["items"] as? [[String: AnyObject]] {
                    if let id = item[0]["id"] as? String {
                        self.currArtistId = id
                        self.getTopTracks()
                    }
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    func getTopTracks() {
        let fetchUrl = "\(baseTrackUrl)/\(currArtistId)/top-tracks?country=US"
        print(fetchUrl)
        
        let url = URL(string: fetchUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                if let tracks = json["tracks"] as? [[String: AnyObject]] {
                    for track in tracks {
                        let newTrack = Track(json: track)
                        self.results.append(newTrack)
                    }
                }
                
                self.songTable.reloadData()
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            self.songTable.reloadData()
        }
        task.resume()
    }
    
    func playSong(index: Int = 0) {
        let track = results[index]
        if let urlString = track.previewUrl {
            let url = URL(string: urlString)
            let player = AVPlayer(url: url!)
            player.play()
        }
    }
    
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredResults = results.filter { result in
//            return candy.name.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        
//        songTable.reloadData()
//    }
    
}

extension MusicPlayer: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let track = results[indexPath.row]
        
        if let name = track.name {
            cell.textLabel?.text = name
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = results[indexPath.row]
        
        if let urlString = track.previewUrl, let url = URL(string: urlString) {
            player.removeAllItems()
            let item = AVPlayerItem(url: url)
            player.insert(item, after: nil)
            player.play()
        }
    }
}

extension MusicPlayer: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        print("Success!")
        if let input = searchController.searchBar.text {
            getNewResults(artist: input)
        }
    }
}
