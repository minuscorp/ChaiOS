import Foundation
import EarlGrey

extension GREYInteraction {

    @discardableResult
    public func assert(_ matcher: @autoclosure () -> GREYMatcher) -> Self {
        return self.__assert(with: matcher())
    }
    
    @discardableResult
    public func using(searchAction: GREYAction, onElementWithMatcher matcher: GREYMatcher) -> Self {
        return self.usingSearch(searchAction, onElementWith: matcher)
    }
}
