//
//  PrimaryIntroViewController.swift
//  ps
//
//  Created by chen on 2024/11/14.
//

import UIKit
import Combine
import CombineCocoa

class PrimaryIntroViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    enum Section {
        case main
    }
    
    struct Item: Hashable {
        let id = UUID()
        //let imageName: String
    }
        
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        setupDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(generateItems(count: 4), toSection: .main)
        self.dataSource.apply(snapshot)
        
    }
    
    override func setupView() {
        super.setupView()
        collectionView.collectionViewLayout = generateLayout()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
    
    override func bindView() {
        super.bindView()
        nextButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                if self.currentIndex < 3 {
                    self.collectionView.scrollToItem(at: IndexPath(item: self.currentIndex + 1, section: 0), at: .centeredHorizontally, animated: true)
                    self.currentIndex += 1
                }  else {
                    // 执行进一步操作 例如进入主页面
                    goAhead()
                }
                self.updateNextButton()
            }
            .store(in: &subscriptions)
    }
    
    func generateItems(count: Int) -> [Item] {
        var items: [Item] = []
        for _ in 0..<count {
            items.append(Item())
        }
        return items
    }
    
    func goAhead() {
        keyWindow?.rootViewController = UINavigationController(rootViewController: IntroViewController())
    }

}

extension PrimaryIntroViewController {

    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        return layout
    }
    
    func setupDataSource() {
        let introItem = UICollectionView.CellRegistration<IntroItem, Item> { cell, indexPath, itemIdentifier in
            cell.contentView.backgroundColor = .random
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: introItem, for: indexPath, item: itemIdentifier)
        }
        
        self.dataSource = dataSource
    }
    
    func updateNextButton() {
        if currentIndex >= 3 {
            nextButton.setAttributedTitle(NSAttributedString(string: "开始"), for: .normal)
            nextButton.backgroundColor = .introMain
        } else {
            nextButton.setAttributedTitle(NSAttributedString(string: "继续"), for: .normal)
            nextButton.backgroundColor = .introMain
        }
    }
    
}

extension PrimaryIntroViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        nextButton.isEnabled = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        nextButton.isEnabled = true
        updateNextButton()
    }
}

extension PrimaryIntroViewController: UICollectionViewDelegate {
    
}

