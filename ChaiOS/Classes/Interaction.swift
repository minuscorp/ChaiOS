import Foundation
import EarlGrey

/**
 Provides the primary methods for test authors to perform actions or asserts on views.

 Each interaction is associated with a view identified by a matcher.
*/
public class Interaction: GreyConvertible {
    
    public typealias Grey = GREYInteraction
    
    private let file: String
    private let line: UInt
    private let matcher: Matcher
    private let index: UInt?
    
    private var selection: GREYInteraction {
        return matcher.toGrey.selected()
    }
    
    init(file: StaticString = #file, line: UInt = #line, matcher: Matcher, index: UInt? = nil) {
        self.file = file.description
        self.line = line
        self.matcher = matcher
        self.index = index
    }
    
    public var toGrey: GREYInteraction {
        return index == nil ? selection : selection.atIndex(index!)
    }
	
	/**
	 Asserts the given condition on the view selected by the current matcher.
	*/
    @discardableResult
    public func assert(_ condition: Condition) -> Self {
        var selection = self.selection
        if let index = index {
            selection = selection.atIndex(index)
        }
        selection.assert(condition.toGrey)
        return self
    }
	
    @discardableResult
    public func assert(_ otherMatcher: Matcher) -> Self {
        self.toGrey.assert(otherMatcher.toGrey)
        return self
    }

    @discardableResult
    public func using(_ action: Action, on condition: Condition) -> Self {
        self.toGrey.using(searchAction: action.toGrey, onElementWithMatcher: Matcher.that(condition).toGrey)
        return self
    }
    
    @discardableResult
    public func using(_ action: Action, on otherMatcher: Matcher) -> Self {
        self.toGrey.using(searchAction: action.toGrey, onElementWithMatcher: matcher.toGrey)
        return self
    }
	/**
	 Performs the given action on the view selected by the current matcher.
	*/
    @discardableResult
    public func perform(_ action: Action) -> Self {
        self.toGrey.__perform(action.toGrey)
        return self
    }
    
    @discardableResult
    public func at(_ index: UInt) -> Interaction {
        return Interaction(matcher: matcher, index: index)
    }
    
    public subscript(_ index: UInt) -> Interaction {
        get {
            return Interaction(matcher: matcher, index: index)
        }
    }
}
