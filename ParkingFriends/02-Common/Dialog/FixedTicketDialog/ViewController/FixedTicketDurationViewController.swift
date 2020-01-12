//
//  FixedTicketDurationViewController.swift
//  ParkingFriends
//
//  Created by PlankFish on 2020/01/12.
//  Copyright © 2020 Hancom Mobility. All rights reserved.
//

import UIKit

class FixedTicketDurationViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fixedTicketTitleLabel: UILabel!
    @IBOutlet weak var hoursPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    private var startDate:Date?
    private var hourRangeList:[Int] = []

    var localizer:LocalizerType = Localizer.shared
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Binding
    
    private func setupHoursPicker() {
        let rows = hoursPicker.numberOfRows(inComponent: 0)
        hoursPicker.selectRow((rows > 0) ? 1 : 0, inComponent: 0, animated: false)
    }
    
    private func setupBinding() {
        fixedTicketTitleLabel.text = localizer.localized("ttl_ticket_fixed_day")
    }
    
    private func setupButtonBinding() {
        saveButton.rx.tap
            .subscribe(onNext: { _ in
                self.dismissModal(animated: true) {
                    let index = self.hoursPicker.selectedRow(inComponent: 0)
                    let hours = self.hourRangeList[index]
                    if let navigation = self.navigationController, let start = self.startDate {
                        (navigation as! FixedTicketNavigationController).completionAction?(start, hours)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public Methods
    
    public func setStartDate(_ date:Date) {
        startDate = date
    }
    
    // MARK: - Local Methods
    
    private func updatePickerHours() {
        if let date = startDate {
            let maxHours:Int = 24 - date.component(.hour)!
            hourRangeList = Array(1...maxHours)
 
            Observable.just(hourRangeList)
                .bind(to: hoursPicker.rx.itemTitles) { _, item in
                    return "\(item)"
            }
            .disposed(by: disposeBag)
        }
    }
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initialize() {
        setupButtonBinding()
        setupHoursPicker()
        setupBinding()
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
