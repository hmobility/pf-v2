//
//  GuideFinishedViewModel.swift
//  ParkingFriends
//
//  Created by PlankFish on 2019/10/31.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import Foundation

import UIKit
import RxCocoa
import RxLocalizer
import RxSwift
import RxViewController

protocol GuideFinishedViewModelType {
    var titleText: Observable<String> { get }
    var subtitleText: Observable<String> { get }
    var pageNumber: Observable<Int> { get }
    var guideImage: Observable<UIImage> { get }
    var beginText: Observable<String> { get }
}

class GuideFinishedViewModel: GuideFinishedViewModelType {
    let titleText: Observable<String>
    let subtitleText: Observable<String>
    let pageNumber: Observable<Int>
    let guideImage: Observable<UIImage>
    let beginText: Observable<String>
    
    init(_ index: Int = 4, localizer: LocalizerType = Localizer.shared) {
        let number = index + 1
        pageNumber = Observable.just(index)
        guideImage = Observable.just(UIImage(named: "imgGuide\(number)")!)
        titleText = Observable.just(localizer.localized("guide_title_\(number)"))
        subtitleText = Observable.just(localizer.localized("guide_subtitle_\(number)"))
        beginText = Observable.just(localizer.localized("guide_finished"))
    }
}
