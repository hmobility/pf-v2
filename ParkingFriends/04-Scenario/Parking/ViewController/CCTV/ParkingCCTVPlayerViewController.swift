//
//  ParkingCCTVPlayerViewController.swift
//  ParkingFriends
//
//  Created by PlankFish on 2020/02/16.
//  Copyright © 2020 Hancom Mobility. All rights reserved.
//

import UIKit

extension ParkingCCTVPlayerViewController : AnalyticsType {
    var screenName: String {
        return "[SCREEN] CCTV Parkinglot Player"
    }
}

class ParkingCCTVPlayerViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    @IBOutlet weak var cctvNavigationView: UIStackView!
    @IBOutlet weak var playerView: ParkingCCTVMediaPlayerView!
    
    var backButtonAction: ((_ flag:Bool) -> Void)?
    var infoButtonAction: ((_ flag:Bool) -> Void)?
    
    private var viewModel: ParkingStatusViewModelType?
    private var videoUrls:[String]?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Binding
    
    private func setupNavigationBinding() {
        if let viewModel = viewModel {
            viewModel.viewTitleText
                .drive(self.navigationItem.rx.title)
                .disposed(by: disposeBag)
        }
    }
    
    private func setupButtonBinding() {
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] _ in
                if let action = self.backButtonAction {
                    action(true)
                }
            })
            .disposed(by: disposeBag)
        
        infoButton.rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] _ in
                if let action = self.infoButtonAction {
                    action(true)
                 }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupPlayer() {
     //   if let urls = viedeoUrls
    }
    
    // MARK: - Public Methods
    
    public func setViewModel(_ viewModel:ParkingStatusViewModelType) {
        self.viewModel = viewModel as! ParkingStatusViewModel
    }
    
    public func setVideoUrls(with urls:[String]) {
        videoUrls = urls
    }
 
    // MARK: - Initialize
    
    private func initialize() {
        setupNavigationBinding()
        setupButtonBinding()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
