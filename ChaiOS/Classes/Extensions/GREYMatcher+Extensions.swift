import Foundation
import EarlGrey

extension GREYMatcher {
    
    public func element(_ matcher: Matcher, file: StaticString = #file, line: UInt = #line) -> GREYInteraction {
        return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
            .selectElement(with: matcher.toGrey)
    }
    
    public func selected(file: StaticString = #file, line: UInt = #line) -> GREYInteraction {
        return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
            .selectElement(with: self)
    }
}
