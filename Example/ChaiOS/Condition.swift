//
//  ViewBuilder.swift
//  ChaiOS_Example
//
//  Created by Francisco García Sierra on 5/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import EarlGrey

public enum Condition {
	case accessibilityID(String)
	case accessibilityLabel(String)
	case interactable
	case enabled
	case hasText(String)
	case isNotVisible
	case kindOf(AnyClass)
	
	var toEarlGrey: GREYMatcher {
		switch self {
		case .accessibilityID(let id):
			return grey_accessibilityID(id)
		case .accessibilityLabel(let label):
			return grey_accessibilityLabel(label)
		case .interactable:
			return grey_interactable()
		case .enabled:
			return grey_enabled()
		case .hasText(let text):
			return grey_text(text)
		case .isNotVisible:
			return grey_notVisible()
		case .kindOf(let theClass):
			return grey_kindOfClass(theClass)
		}
	}
}
