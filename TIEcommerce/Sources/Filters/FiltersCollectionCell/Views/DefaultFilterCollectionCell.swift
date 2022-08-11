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
import TIUIElements
import UIKit

/*

 У тебя в кейсах по сути одно и то-же написано. Я таки рекомендую у cellAppearance хранить 2 экземпляра структуры с этими свойствами в normalAppearance и в selectedAppearance, а здесь сделать один метод в который ты будешь эту структуру передавать и применять оттуда цвета и ширину линии.




 Предлагаю визуально разделить переменные, либо завести структурку FilterCellState и дальше либо Appearance или Configuration или какой-нибудь микс из них в названии. Держать там 3 свойства color, backgroundColor и fontColor. А здесь держать 2 экземпляра этой струкруты для normal и selected состояний. Ну и кажется что нет необходимости делать BaseFilterCellAppearance классом, вместо стукруры

 У тебя в инициализаторе 10 аргументов, а могло быть 4. + это упроситло бы применение апиранса. Ты просто пилишь один метод применения, и туда передаешь либо свойство normalAppearance, либо selectedAppearance и все. А внутри у тебя одинаковая реализация. + можно было бы определить набор стандартных апирансов для разных стейтов и при инициализации использовать их через .defaultSelectedAppearance, .defaultNormalAppearance и комбинировать их в нужном порядке. А сейчас нужно будет заполнять 10 аргументов инициализатора.

 Ну и остался открытым вопрос, а почему собственно BaseFilterCellAppearance класс, а не структура? И есть ли смысл делать свойства переменными, а не константами?
 */

open class DefaultFilterCollectionCell: ContainerCollectionViewCell<UILabel>, ConfigurableView {

    open var selectedStateAppearance: FilterCellStateAppearance {
        .defaultSelectedAppearance
    }

    open var normalStateAppearance: FilterCellStateAppearance {
        .defaultNormalAppearance
    }

    open override var isSelected: Bool {
        didSet {
            let appearance = isSelected ? selectedStateAppearance : normalStateAppearance
            updateAppearance(with: appearance)
        }
    }

    open override func configureAppearance() {
        super.configureAppearance()
        
        updateAppearance(with: normalStateAppearance)
    }

    // MARK: - ConfigurableView

    open func configure(with viewModel: DefaultFilterCellViewModel) {
        wrappedView.text = viewModel.title
    }

    // MARK: - Open methdos

    open func updateAppearance(with appearance: FilterCellStateAppearance) {
        contentInsets = appearance.contentInsets
        wrappedView.textColor = appearance.fontColor

        backgroundColor = appearance.backgroundColor
        layer.borderColor = appearance.borderColor.cgColor
        layer.borderWidth = appearance.borderWidth
        layer.round(corners: .allCorners, radius: appearance.cornerRadius)
    }
}

extension FilterCellStateAppearance {
    static var defaultSelectedAppearance: FilterCellStateAppearance {
        .init(borderColor: .systemGreen, backgroundColor: .white, fontColor: .systemGreen, borderWidth: 1)
    }

    static var defaultNormalAppearance: FilterCellStateAppearance {

        .init(borderColor: .lightGray, backgroundColor: .lightGray, fontColor: .black, borderWidth: 0)
    }
}
