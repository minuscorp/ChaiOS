import Foundation
import EarlGrey

/**
 Static container generic UI interaction methods,
 such as rotate the device screen or close the keyboard.
*/
public final class ChaiOS {
	
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

/**
 Protocol for container classes of UI elements.

 This protocol groups UI elements and grants access to basic actions,
 such as perform() and assert()
*/
public protocol Screen { }

extension Screen {
	
	public func test(_ closure: (Self) -> Void) {
		closure(self)
	}
	
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
