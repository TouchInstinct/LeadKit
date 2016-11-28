//
//  ImageOperationPerformer.swift
//  LeadKit
//
//  Created by Anton on 26.11.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation
import RxSwift

public protocol ImageOperationPerformer {
    func performImageOperation(operation: ImageOperation) -> Observable<UIImage>
}
