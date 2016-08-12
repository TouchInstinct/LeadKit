//
//  CellCreationType.swift
//  LeadKit
//
//  Created by Ivan Smolin on 26/07/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import Foundation

/**
 enum which describes cell creation behaviour of CellsControllerProtocol

 - Preloaded:   cells is generated in advance
 - OnTheFlight: cells is created on demand
 */
public enum CellCreationType: Int {

    case Preloaded = 0
    case OnTheFlight = 1

}
