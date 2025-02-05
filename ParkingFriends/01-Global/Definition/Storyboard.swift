//
//  Storyboard.swift
//  ParkingFriends
//
//  Created by PlankFish on 2019/10/29.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import UIKit

struct Storyboard {
    static let splash = UIStoryboard(name: "Splash", bundle: nil)
    static let terms = UIStoryboard(name: "Terms", bundle: nil)
    static let tutorial = UIStoryboard(name: "Tutorial", bundle: nil)
    static let entry = UIStoryboard(name: "Entry", bundle: nil)
    static let registration = UIStoryboard(name: "Registration", bundle: nil)
    static let main = UIStoryboard(name: "Main", bundle: nil)
    static let detail = UIStoryboard(name: "Detail", bundle: nil)
    static let event = UIStoryboard(name: "Event", bundle: nil)
    static let payment = UIStoryboard(name: "Payment", bundle: nil)
    static let menu = UIStoryboard(name: "Menu", bundle: nil)
    static let parking = UIStoryboard(name: "Parking", bundle: nil)
    static let search = UIStoryboard(name: "Search", bundle: nil)
    static let point = UIStoryboard(name: "Point", bundle: nil)
}

struct Dialog {
    static let timeTicket = UIStoryboard(name: "TimeTicketDialog", bundle: nil)
    static let fixedTicket = UIStoryboard(name: "FixedTicketDialog", bundle: nil)
    static let monthlyTicket = UIStoryboard(name: "MonthlyTicketDialog", bundle: nil)
}
