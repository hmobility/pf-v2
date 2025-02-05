//
//  PaymentGuideViewController.swift
//  ParkingFriends
//
//  Created by PlankFish on 2019/12/02.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import UIKit


extension PaymentGuideViewController : AnalyticsType {
    var screenName: String {
        return "[SCREEN] Payment Guide"
    }
}

class PaymentGuideViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var guideTextView: UITextView!
    @IBOutlet weak var noDisplayLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var displayCheckButton: UIButton!
    
    @IBOutlet weak var displayCheckGuideView: UIStackView!
    
    var dismissAction: ((_ flag:Bool) -> Void)?
    
    private var checkMode:Bool = false
    
    private var viewModel: PaymentGuideViewModelType
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    
    init() {
        self.viewModel = PaymentGuideViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = PaymentGuideViewModel()
        super.init(coder: aDecoder)
    }
    
    private func initialize() {
        setupBinding()
        setupButtonBinding()
        
        displayCheckGuideView.isHidden = checkMode ? false : true
    }
    
    // MARK: - Public Methods
    
    public func showCheckMdode(_ flag:Bool) {
        checkMode = flag
    }
    
    // MARK: - Binding
      
    private func setupBinding() {
        viewModel.viewTitleText
                .drive(titleLabel.rx.text)
                .disposed(by: disposeBag)
        
        viewModel.contentsText
                .map({ text in
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.lineSpacing = 7
                    paragraph.headIndent = 10
                    
                    return  NSMutableAttributedString(string: text,
                                                      attributes:[NSAttributedString.Key.foregroundColor: Color.darkGrey,
                                                                NSAttributedString.Key.font: Font.gothicNeoRegular15,
                                                                NSAttributedString.Key.paragraphStyle:paragraph])
                })
                .drive(guideTextView.rx.attributedText)
                .disposed(by: disposeBag)
        
        viewModel.closeText
            .drive(closeButton.rx.title(for: .normal))
                .disposed(by: disposeBag)
        
        viewModel.agreementText
                .drive(agreementButton.rx.title(for: .normal))
                .disposed(by: disposeBag)
        
        viewModel.noDisplayText
                 .drive(noDisplayLabel.rx.text)
                 .disposed(by: disposeBag)
    }
    
    private func setupButtonBinding() {
        displayCheckButton.rx.tap
            .asObservable()
            .map { (_) -> Bool in
                return !self.displayCheckButton.isSelected
            }
            .map { selected in
                self.displayCheckButton.isSelected = selected
                return selected
            }
            .bind(to: self.viewModel.displayState)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] _ in
                self.dismissModal(animated: false) {
                    if let action = self.dismissAction {
                        action(true)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        agreementButton.rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] _ in
                 self.dismissModal(animated: false)
            })
            .disposed(by: disposeBag)
    }
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
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
