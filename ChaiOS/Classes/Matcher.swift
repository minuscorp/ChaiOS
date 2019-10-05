import Foundation
import EarlGrey

public enum Matcher {
    case that(Condition)
    case any([Condition])
    case all([Condition])
}

extension Matcher: GreyConvertible {
    public typealias Grey = GREYMatcher
    
    public var toGrey: GREYMatcher {
        switch self {
        case .that(let condition):
            return condition.toGrey
        case .any(let conditions):
            return grey_anyOf(conditions.map { $0.toGrey })
        case .all(let conditions):
            return grey_allOf(conditions.map { $0.toGrey })
        }
    }
}

extension Matcher {
    
    public func selected(file: StaticString = #file, line: UInt = #line) -> Interaction {
        return Interaction.init(file: file, line: line, matcher: self)
    }
    
    public subscript(_ at: UInt) -> Interaction {
        return Interaction(matcher: self, index: at)
    }
}

extension Matcher {

    /**
     Count the number of elements that matches the given `Matcher` in the current view hierarchy.
     - Parameter condition: An condition closure to be evaluated over the matched element in the hierarchy.
     - Returns: The number of ocurrences of the given `Matcher` using the optional condition in the current view hierarchy.
     - Note: An example usage of this operator would be:
     ```
     let numberOfCells = ChaiOS
        .that(.kindOf(UITableViewCell.self))
        .occurrences
     ```
     */
    public func occurrences(_ condition: ((Any) -> Bool)? = nil) -> Int {
        var index: Int = 0
        let countCondition: Condition = .custom(matcherBlock: { element in
            if self.toGrey.matches(element) {
                if condition?(element) ?? true {
                    index += 1
                }
            }
            return false
        }, descriptionBlock: { (description: AnyObject?) in
            // swiftlint:disable:next force_cast
            let greyDescription: GREYDescription = description as! GREYDescription
            greyDescription.appendText("Count of Matcher")
        })
        ChaiOS.that(countCondition)
            .selected()
            .assert(.notNil)
        return index
    }
}
