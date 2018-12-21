import Foundation

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
		return ChaiOS.with(matcher)
	}
	
	public static func that(_ condition: Condition) -> Matcher {
		return ChaiOS.that(condition)
	}
	
	public static func any(_ conditions: Condition...) -> Matcher {
		return ChaiOS.any(conditions)
	}
	
	public static func all(_ conditions: Condition...) -> Matcher {
		return ChaiOS.all(conditions)
	}
	
	public static func any(_ conditions: [Condition]) -> Matcher {
		return ChaiOS.any(conditions)
	}
	
	public static func all(_ conditions: [Condition]) -> Matcher {
		return ChaiOS.all(conditions)
	}
}
