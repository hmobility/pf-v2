//
//  ParkinglotListViewController.swift
//  ParkingFriends
//
//  Created by PlankFish on 2019/12/11.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import UIKit
import BetterSegmentedControl

extension ParkingTapViewController: AnalyticsType {
    var screenName: String {
        return "[SCREEN] Parkinglot Tap"
    }
}

class ParkingTapViewController: UIViewController {
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    @IBOutlet weak var tapSegmentedControl: BetterSegmentedControl!
    
    @IBOutlet weak var timeTicketButton: UIButton!
    @IBOutlet weak var fixedTicketButton: UIButton!
    @IBOutlet weak var monthlyTicketButton: UIButton!

    @IBOutlet weak var sortOrderButton: UIButton!
    
    private let disposeBag = DisposeBag()

    private lazy var viewModel: ParkingTapViewModelType = ParkingTapViewModel()
    
    // MARK: - Binding
    
    private func setupBindings() {
        viewModel.timeTicketText
            .drive(timeTicketButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.fixedTicketText
            .drive(fixedTicketButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.monthlyTicketText
            .drive(monthlyTicketButton.rx.title())
            .disposed(by: disposeBag)
   
        viewModel.sortOrderText.asDriver()
            .drive(sortOrderButton.rx.title())
            .disposed(by: disposeBag)
    }
    
    private func setupTapMenuSegmentedItems() {
        tapSegmentedControl.options = [.backgroundColor(UIColor.white),
                                       .animationDuration(0),
                                       .panningDisabled(true)]

        viewModel.tapMenuItems
            .asDriver()
            .map { items in
                return items.map { $0.title }
            }
            .drive(onNext: { [unowned self] titles in
                self.updateSegmentItems(with: titles)
            })
            .disposed(by: disposeBag)
        
        viewModel.getSelectedProductItem()
            .asObservable()
            .subscribe(onNext: { [unowned self] (index, type, title) in
                self.tapSegmentedControl.setIndex(index)
            })
            .disposed(by: disposeBag)
        
        tapSegmentedControl.rx.selected
            .asDriver()
            .drive(onNext: { selectedIndex in
                self.viewModel.setSelectedProductItem(with: selectedIndex)
            })
            .disposed(by: disposeBag)
    }
    private func setupTapButtonBinding() {

        viewModel.selectedProductType
        .asDriver()
            .drive(onNext: { type in
                self.timeTicketButton.isSelected = (type == .time) ? true : false
                self.fixedTicketButton.isSelected = (type == .fixed) ? true : false
                self.monthlyTicketButton.isSelected = (type == .monthly) ? true : false
            })
            .disposed(by: disposeBag)
        
        let observable = Observable.merge (
            timeTicketButton.rx.tap.map { return ProductType.time },
            fixedTicketButton.rx.tap.map { return ProductType.fixed },
            monthlyTicketButton.rx.tap.map { return ProductType.monthly}
        )
        
        observable.asObservable()
            .subscribe(onNext: { type in
                self.viewModel.setProductType(type)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setupSortOrderButtonBinding() {
        sortOrderButton.rx.tap
            .asObservable()
            .map({
                return self.viewModel.selectedSortType.value
            })
            .asDriver(onErrorJustReturn: .distance)
            .drive(onNext: { (sort) in
                self.showSortOrderDiaglog(with: sort)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Tap Segmented Control
    
    private func updateSegmentItems(with titles:[String]) {
        tapSegmentedControl.segments = LabelSegment.segments(withTitles: titles,
                                                             normalFont: Font.gothicNeoMedium18,
                                                             normalTextColor: Color.coolGrey,
                                                             selectedFont: Font.gothicNeoMedium18,
                                                             selectedTextColor: Color.darkGrey3)
    }

    // MARK: - Local Methdos
    
    private func showSortOrderDiaglog(with sortType:SortType) {
        SortOrderDialog.show(selected: sortType) { (finished, sort) in
            if finished {
                self.viewModel.setSortType(sort!)
            }
        }
    }
    
    // MARK: - Public Methods
    
    public func getViewModel() -> ParkingTapViewModelType {
        return self.viewModel
    }
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initialize() {
        setupBindings()
        setupTapMenuSegmentedItems()
      //  setupTapButtonBinding()
        setupSortOrderButtonBinding()
        fetchWithinElements()
    }
    
    // MARK: - Fetch Table View
    
    private func fetchWithinElements() {
        tableView.rx.itemSelected.asDriver()
            .drive(onNext: { indexPath in
            //   self.viewModel.loadModels(brandIdx: indexPath.row)
            })
            .disposed(by: disposeBag)
        
        viewModel.elements
            .map { source in
                return source.count == 0
            }
            .subscribe(onNext: { isEmpty in
                self.dataView.isHidden = isEmpty ? true : false
            })
            .disposed(by: disposeBag)
        
        viewModel.elements
            .bind(to: tableView.rx.items) { (tableView, row, item) -> UITableViewCell in
                let indexPath = IndexPath(item: row, section: 0)
                let sort = self.viewModel.selectedSortType.value
                
                if sort == .distance {
                    let cell = self.tableView.dequeueReusableCell(withIdentifier:
                    "ParkingDistanceTableViewCell", for: indexPath) as! ParkingDistanceTableViewCell
                    cell.configure(item, tags: self.viewModel.getTags(item))
                    return cell
                } else {
                    let cell = self.tableView.dequeueReusableCell(withIdentifier:
                        "ParkingPriceTableViewCell", for: indexPath) as! ParkingPriceTableViewCell
                    cell.configure(item, tags: self.viewModel.getTags(item))
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Navigation
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
