//
//  MenuViewModel.swift
//  ParkingFriends
//
//  Created by PlankFish on 2019/12/30.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import Foundation

protocol MenuViewModelType {
    
    var addText: Driver<String> { get }
    var addCarText: Driver<String> { get }
    var usernameText: BehaviorRelay<String> { get }
    
    var cardManagementText:Driver<String>  { get }
    var pointChargeText:Driver<String>  { get }
    var myCouponText:Driver<String>  { get }
    
    var paymentHistoryText:Driver<String>  { get }
    var myInfoText:Driver<String>  { get }
    var eventsText:Driver<String>  { get }
    var noticeText:Driver<String>  { get }
    var faqText:Driver<String>  { get }
    var settingsText:Driver<String>  { get }
    
    var reportNewParkinglotText:Driver<String>  { get }
    var shareMyParkinglotText:Driver<String>  { get }
}

class MenuViewModel: MenuViewModelType {
    var addText: Driver<String>
    var addCarText: Driver<String>
    var usernameText: BehaviorRelay<String> = BehaviorRelay(value:"")
    
    var cardManagementText: Driver<String>
    var pointChargeText: Driver<String>
    var myCouponText: Driver<String>
    
    var paymentHistoryText: Driver<String>
    var myInfoText: Driver<String>
    var eventsText: Driver<String>
    var noticeText: Driver<String>
    var faqText: Driver<String>
    var settingsText: Driver<String>
    
    var reportNewParkinglotText: Driver<String>
    var shareMyParkinglotText: Driver<String>
    
    var localizer:LocalizerType
    
    // MARK: - Initiailize
    
    init(localizer: LocalizerType = Localizer.shared) {
        self.localizer = localizer
        
        addText = localizer.localized("btn_add")
        addCarText = localizer.localized("ttl_my_car_add")
        
        cardManagementText = localizer.localized("ttl_card_management")
        pointChargeText = localizer.localized("ttl_point_charge")
        myCouponText = localizer.localized("ttl_my_coupon")
        
        paymentHistoryText = localizer.localized("ttl_menu_payment_history")
        myInfoText = localizer.localized("ttl_menu_my_info")
        eventsText = localizer.localized("ttl_menu_event")
        noticeText = localizer.localized("ttl_menu_notice")
        faqText = localizer.localized("ttl_menu_faq")
        settingsText = localizer.localized("ttl_menu_setting")
        
        reportNewParkinglotText = localizer.localized("btn_parkinglot_report")
        shareMyParkinglotText = localizer.localized("btn_my_parkinglot_sharing")
    }
}
