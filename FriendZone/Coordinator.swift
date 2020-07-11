//
//  Coordinator.swift
//  FriendZone
//
//  Created by Oliver Lippold on 04/07/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

