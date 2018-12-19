import Foundation
import EarlGrey

public class Interaction {
    
    private let file: String
    private let line: UInt
    private let matcher: Matcher
    
    init(file: StaticString = #file, line: UInt = #line, matcher: Matcher) {
        self.file = file.description
        self.line = line
        self.matcher = matcher
    }
    
    @discardableResult
    public func assert(_ condition: Condition) -> Self {
        matcher.toGrey.selected().assert(condition.toGrey)
        return self
    }
    
    @discardableResult
    public func assert(_ otherMatcher: Matcher) -> Self {
        matcher.toGrey.selected().assert(otherMatcher.toGrey)
        return self
    }

    @discardableResult
    public func using(_ action: Action, on condition: Condition) -> Self {
        matcher.toGrey.selected().using(searchAction: action.toGrey, onElementWithMatcher: Matcher.that(condition).toGrey)
        return self
    }
    
    @discardableResult
    public func using(_ action: Action, on otherMatcher: Matcher) -> Self {
        matcher.toGrey.selected().using(searchAction: action.toGrey, onElementWithMatcher: matcher.toGrey)
        return self
    }
}
