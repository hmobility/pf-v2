//
//  ParkinglotCardViewModel.swift
//  ParkingFriends
//
//  Created by PlankFish on 2019/12/24.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import Foundation
import UIKit

protocol ParkingCardViewModelType {
    var priceUnitText: Driver<String> { get }
    
    var elements:BehaviorRelay<[WithinElement]> { get }
    
    var ableElements: BehaviorRelay<[WithinElement]> { get }    // Add by Rao
    
    func setWithinElements(_ elements:[WithinElement]?)
    func getTags(_ element:WithinElement) -> [String]
}

class ParkingCardViewModel: ParkingCardViewModelType {
    var priceUnitText: Driver<String>
    
    var elements: BehaviorRelay<[WithinElement]> = BehaviorRelay(value: [])
    var ableElements: BehaviorRelay<[WithinElement]> = BehaviorRelay(value: [])     // Add by Rao
    
    private var localizer:LocalizerType
    
    // MARK: - Initialize
    
    init(localizer: LocalizerType = Localizer.shared) {
        self.localizer = localizer
        
        self.priceUnitText = localizer.localized("txt_won")

        initialize()
    }
    
    func initialize() {
        setupBinding()
    }
    
    // MARK: - Binding
    
    func setupBinding() {
    }
    
    // MARK: - Public Methods
    
    func getTags(_ element:WithinElement) -> [String] {
        var tags:[String] = []
        
        if element.cctvFlag {
            tags.append(localizer.localized("itm_cctv"))
        }
        
        if element.outsideFlag {
            tags.append(localizer.localized("itm_cctv"))
        }
        
        if element.chargerFlag {
            tags.append(localizer.localized("itm_evc"))
        }
        
        if element.iotSensorFlag {
            tags.append(localizer.localized("itm_iot"))
        }
        
        tags.append((element.outsideFlag) ? localizer.localized("itm_outdoor") : localizer.localized("itm_indoor"))
        
        return tags
    }
    
    func setWithinElements(_ elements:[WithinElement]?){
        if let items = elements {
            // Add by Rao
            //*
            let availItems = items.filter { (item) -> Bool in
                return ( item.available == true )
            }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////
            self.ableElements.accept(availItems)
            //*/
//            self.elements.accept(items)
            self.elements.accept(items)
        } else {
            self.elements.accept([])
        }
    }
}
