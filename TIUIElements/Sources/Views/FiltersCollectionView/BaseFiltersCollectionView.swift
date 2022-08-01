//
//  Copyright (c) 2022 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import TIUIKitCore
import UIKit

public typealias DefaultBaseFiltersCollectionView = BaseFiltersCollectionView<BaseFilterCollectionItem<BaseFilterCollectionCell,
                                                                                                DefaultFilterPropertyValue>>

open class BaseFiltersCollectionView<Cell: FilterCollectionItem>: BaseInitializableView, ConfigurableView {

    typealias Director = DefaultFiltersCollectionDirector<Cell>

    private var collectionDirector: Director

    public var collectionView: UICollectionView

    public var layout: CollectionViewLayoutProtocol

    public weak var viewModel: DefaultFiltersViewModel?

    open weak var filtersDelegate: FilterItemsDelegate?

    // MARK: - Init

    public init(layout: CollectionViewLayoutProtocol) {
        self.layout = layout
        self.collectionView = .init(frame: .zero, collectionViewLayout: layout.collectionViewLayout)
        self.collectionDirector = .init(collectionView: collectionView)

        super.init(frame: .zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    open override func addViews() {
        super.addViews()

        addSubview(collectionView)
    }

    open override func configureLayout() {
        super.configureLayout()

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(collectionView.edgesEqualToSuperview())
    }

    open override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .white
        collectionView.backgroundColor = .white
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: DefaultFiltersViewModel) {
        self.viewModel = viewModel
        
        viewModel.filtersCollectionHolder = self
        collectionDirector.delegate = viewModel

        updateView()
    }
}

// MARK: - FiltersCollectionHolder

extension BaseFiltersCollectionView: FiltersCollectionHolder {
    open func select(_ items: [FilterPropertyValueRepresenter]) {
        guard let viewModel = viewModel else { return }

        items.forEach { item in
            if let index = viewModel.filters.firstIndex(of: item as! DefaultFilterPropertyValue) {
                viewModel.filters[index].isSelected = true
            }
        }
    }

    open func deselect(_ items: [FilterPropertyValueRepresenter]) {
        guard let viewModel = viewModel else { return }

        items.forEach { item in
            if let index = viewModel.filters.firstIndex(of: item as! DefaultFilterPropertyValue) {
                viewModel.filters[index].isSelected = false
            }
        }
    }

    open func updateView() {
        guard let viewModel = viewModel else { return }

        collectionDirector.collectionItems = viewModel.filters.map {
            Cell(filter: $0 as! Cell.Filter, viewModel: $0 as! Cell.ViewModel)
        }
    }
}

extension UIView {
    func edgesEqualToSuperview(constant c: CGFloat = .zero) -> [NSLayoutConstraint] {
        guard let superview = self.superview else {
            fatalError("\(self.description) doesn't have superview")
        }

        var constraints = [NSLayoutConstraint]()

        constraints.append(topAnchor.constraint(equalTo: superview.topAnchor, constant: c))
        constraints.append(trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: c))
        constraints.append(bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: c))
        constraints.append(leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: c))

        return constraints
    }
}
