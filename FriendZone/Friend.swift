//
//  Friend.swift
//  FriendZone
//
//  Created by Oliver Lippold on 27/06/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import Foundation

struct Friend: Codable {
    var name: String = "New friend"
    var timeZone: TimeZone = TimeZone.current
}
