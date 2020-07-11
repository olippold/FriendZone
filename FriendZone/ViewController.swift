//
//  ViewController.swift
//  FriendZone
//
//  Created by Oliver Lippold on 27/06/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, Storyboarded {
    var friends = [Friend]()
    var selectedFriend = -1
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        title = "Friend Zone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timeZone
        dateFormatter.timeStyle = .short
        
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = indexPath.row
        coordinator?.configure(friend: friends[indexPath.row])
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        guard let savedData = defaults.data(forKey: "Friends") else { return }
        
        let decoder = JSONDecoder()
        
        guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else {
            return
        }
        
        friends = savedFriends
    }
    
    func saveDats() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let savedData = try? encoder.encode(friends) else {
            fatalError("Unable to encode friends data.")
        }
        
        defaults.set(savedData, forKey: "Friends")
    }
    
    @objc func addFriend() {
        let friend = Friend()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveDats()
        selectedFriend = friends.count - 1
        coordinator?.configure(friend: friend)
    }
    
   
    
    func update(friend: Friend) {
        guard selectedFriend >= 0 else { return }
        
        tableView.reloadData()
        friends[selectedFriend] = friend
        saveDats()
    }


}

