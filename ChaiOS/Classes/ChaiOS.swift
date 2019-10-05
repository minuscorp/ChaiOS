import Foundation
import EarlGrey

// TODO: Document the class
public final class ChaiOS {
    
    public static func with(_ matcher: Matcher) -> Interaction {
        return Interaction(matcher: matcher)
    }
    
    public static func that(_ condition: Condition) -> Matcher {
        return Matcher.that(condition)
    }
    
    public static func any(_ conditions: Condition...) -> Matcher {
        return Matcher.any(conditions)
    }
    
    public static func all(_ conditions: Condition...) -> Matcher {
        return Matcher.all(conditions)
    }
    
    public static func any(_ conditions: [Condition]) -> Matcher {
        return Matcher.any(conditions)
    }
    
    public static func all(_ conditions: [Condition]) -> Matcher {
        return Matcher.all(conditions)
    }
}

extension ChaiOS {
    
    public static func rotateDevice(to orientation: UIDeviceOrientation) throws {
        var error: NSError?
        EarlGreyImpl.invoked(fromFile: #file, lineNumber: #line).rotateDevice(to: orientation, errorOrNil: &error)
        if let error = error {
            throw error
        }
    }
    
    public static func dismissKeyboard() throws {
        var error: NSError?
        EarlGreyImpl.invoked(fromFile: #file, lineNumber: #line).dismissKeyboardWithError(&error)
        if let error = error {
            throw error
        }
    }
    
    public static func condition(with: Matcher) -> Interaction {
        
    }
}
