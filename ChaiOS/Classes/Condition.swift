import Foundation
import EarlGrey
#if os(iOS)
import UIKit
#endif

public enum Condition: GreyConvertible {
    
    public typealias Grey = GREYMatcher

    case keyWindow
    case accessibilityID(String)
    case accessibilityLabel(String)
    case accessibilityValue(String)
    case accessibilityTrait(UIAccessibilityTraits)
    case accessibilityFocused
    case accessibilityHint(String)
    case firstResponder
    case systemAlertViewShown
    case minimumVisiblePercent(CGFloat)
    case sufficientlyVisible
    case accessibilityElement
    case progress(GREYMatcher)
    case respondsToSelector(Selector)
    case conformsToProtocol(Protocol)
    case ancestor(GREYMatcher)
    case descendant(GREYMatcher)
    case buttonTitle(String)
    case scrollViewContentOffset(CGPoint)
    case stepperValue(Double)
    case sliderValueMatcher(GREYMatcher)
    case datePickerValue(Date)
    case pickerColumnSetToValue(column: Int, value: String?)
    case selected
    case userInteractionEnabled
    case layout(constraints: [String], referenceElementMatcher: GREYMatcher)
    case interactable
    case enabled
    case `nil`
    case notNil
    case switchWithOnState(Bool)
    case closeTo(value: Double, delta: Double)
    case anything
    case equalTo(Any)
    case lessThan(Any)
    case greaterThan(Any)
    case scrolledToContentEdge(ContentEdge)
    case text(String)
    case isNotVisible
    case kindOf(AnyClass)
    case textFieldValue(String)
    case custom(matcherBlock: (Any) -> Bool, descriptionBlock: (AnyObject?) -> Void)

    public var toGrey: GREYMatcher {
        switch self {
        case .keyWindow:
            return grey_keyWindow()
        case .accessibilityValue(let value):
            return grey_accessibilityValue(value)
        case .accessibilityID(let id):
            return grey_accessibilityID(id)
        case .accessibilityLabel(let label):
            return grey_accessibilityLabel(label)
        case .accessibilityTrait(let traits):
            return grey_accessibilityTrait(traits)
        case .accessibilityFocused:
            return grey_accessibilityFocused()
        case .accessibilityHint(let hint):
            return grey_accessibilityHint(hint)
        case .firstResponder:
            return grey_firstResponder()
        case .systemAlertViewShown:
            return grey_systemAlertViewShown()
        case .minimumVisiblePercent(let percent):
            return grey_minimumVisiblePercent(percent)
        case .respondsToSelector(let selector):
            return grey_respondsToSelector(selector)
        case .conformsToProtocol(let `protocol`):
            return grey_conformsToProtocol(`protocol`)
        case .ancestor(let ancestorMatcher):
            return grey_ancestor(ancestorMatcher)
        case .descendant(let descendantMatcher):
            return grey_descendant(descendantMatcher)
        case .buttonTitle(let title):
            return grey_buttonTitle(title)
        case .scrollViewContentOffset(let offset):
            return grey_scrollViewContentOffset(offset)
        case .stepperValue(let value):
            return grey_stepperValue(value)
        case .sliderValueMatcher(let matcher):
            return grey_sliderValueMatcher(matcher)
        case .datePickerValue(let date):
            return grey_datePickerValue(date)
        case .pickerColumnSetToValue(let column, let value):
            return grey_pickerColumnSetToValue(column, value)
        case .selected:
            return grey_selected()
        case .userInteractionEnabled:
            return grey_userInteractionEnabled()
        case .layout(let constraints, let referenceElementMatcher):
            return grey_layout(constraints, referenceElementMatcher)
        case .nil:
            return grey_nil()
        case .notNil:
            return grey_notNil()
        case .switchWithOnState(let on):
            return grey_switchWithOnState(on)
        case .closeTo(let value, let delta):
            return grey_closeTo(value, delta)
        case .anything:
            return grey_anything()
        case .sufficientlyVisible:
            return grey_sufficientlyVisible()
        case .accessibilityElement:
            return grey_accessibilityElement()
        case .progress(let comparisonMatcher):
            return grey_progress(comparisonMatcher)
        case .equalTo(let value):
            return grey_equalTo(value)
        case .lessThan(let value):
            return grey_lessThan(value)
        case .greaterThan(let value):
            return grey_greaterThan(value)
        case .scrolledToContentEdge(let contentEdge):
            return grey_scrolledToContentEdge(contentEdge.toGrey)
        case .interactable:
            return grey_interactable()
        case .enabled:
            return grey_enabled()
        case .text(let text):
            return grey_text(text)
        case .isNotVisible:
            return grey_notVisible()
        case .kindOf(let theClass):
            return grey_kindOfClass(theClass)
        case .textFieldValue(let string):
            return grey_textFieldValue(string)
        case .custom(let matcherBlock, let descriptionBlock):
            return GREYElementMatcherBlock.matcher(
                matchesBlock: matcherBlock,
                descriptionBlock: descriptionBlock)
        }
    }
}

extension Condition {
    
    public static func with(name: String, timeout: CFTimeInterval, matcher: Interaction, assertion: Matcher) -> Bool {
        let timeoutCondition: GREYCondition = GREYCondition(name: name, block: {
            var error: NSError?
            matcher.toGrey.__assert(with: assertion.toGrey, error: &error)
            return error == nil
        })
        return timeoutCondition.wait(withTimeout: timeout)
    }
}
