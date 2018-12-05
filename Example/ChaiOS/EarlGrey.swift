import Foundation
import EarlGrey
#if MIYOIGO
@testable import MiYoigo
#elseif MASMOVIL
@testable import MasMovil
#endif

public func GREYAssert(_ expression: @autoclosure () -> Bool, reason: String) {
	GREYAssert(expression, reason, details: "Expected expression to be true")
}

public func GREYAssertTrue(_ expression: @autoclosure () -> Bool, reason: String) {
	GREYAssert(expression(), reason, details: "Expected the boolean expression to be true")
}

public func GREYAssertFalse(_ expression: @autoclosure () -> Bool, reason: String) {
	GREYAssert(!expression(), reason, details: "Expected the boolean expression to be false")
}

public func GREYAssertNotNil(_ expression: @autoclosure ()-> Any?, reason: String) {
	GREYAssert(expression() != nil, reason, details: "Expected expression to be not nil")
}

public func GREYAssertNil(_ expression: @autoclosure () -> Any?, reason: String) {
	GREYAssert(expression() == nil, reason, details: "Expected expression to be nil")
}

public func GREYAssertEqual(_ left: @autoclosure () -> AnyObject?, right: @autoclosure () -> AnyObject?, reason: String) {
	GREYAssert(left() === right(), reason, details: "Expected left term to be equal to right term")
}

public func GREYAssertNotEqual(_ left: @autoclosure () -> AnyObject?, _ right: @autoclosure () -> AnyObject?, reason: String) {
	GREYAssert(left() !== right(), reason, details: "Expected left term to not equal the right term")
}

public func GREYAssertEqualObjects<T: Equatable>( _ left: @autoclosure () -> T?, _ right: @autoclosure () -> T?, reason: String) {
	GREYAssert(left() == right(), reason, details: "Expected object of the left term to be equal" +
		" to the object of the right term")
}

public func GREYAssertNotEqualObjects<T: Equatable>( _ left: @autoclosure () -> T?, _ right: @autoclosure () -> T?, reason: String) {
	GREYAssert(left() != right(), reason, details: "Expected object of the left term to not" +
		" equal the object of the right term")
}

public func GREYFail(_ reason: String) {
	EarlGrey.handle(exception: GREYFrameworkException(name: kGREYAssertionFailedException,
													  reason: reason),
					details: "")
}

public func GREYFailWithDetails(_ reason: String, details: String) {
	EarlGrey.handle(exception: GREYFrameworkException(name: kGREYAssertionFailedException,
													  reason: reason),
					details: details)
}

private func GREYAssert(_ expression: @autoclosure () -> Bool, _ reason: String, details: String) {
	GREYSetCurrentAsFailable()
	GREYWaitUntilIdle()
	if !expression() {
		EarlGrey.handle(exception: GREYFrameworkException(name: kGREYAssertionFailedException,
														  reason: reason),
						details: details)
	}
}

private func GREYSetCurrentAsFailable() {
	let greyFailureHandlerSelector =
		#selector(GREYFailureHandler.setInvocationFile(_:andInvocationLine:))
	guard let greyFailureHandler =
		Thread.current.threadDictionary.value(forKey: kGREYFailureHandlerKey) as? GREYFailureHandler else {
			fatalError("GREYFailureHandler error")
	}
	if greyFailureHandler.responds(to: greyFailureHandlerSelector) {
		greyFailureHandler.setInvocationFile!(#file, andInvocationLine: #line)
	}
}

private func GREYWaitUntilIdle() {
	GREYUIThreadExecutor.sharedInstance().drainUntilIdle()
}

open class EarlGrey: NSObject {
	public static func selectElement(with matcher: GREYMatcher, file: StaticString = #file, line: UInt = #line) -> GREYInteraction {
		return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
			.selectElement(with: matcher)
	}
	
	@available(*, deprecated, renamed: "selectElement(with:)")
	open class func select(elementWithMatcher matcher: GREYMatcher, file: StaticString = #file, line: UInt = #line) -> GREYElementInteraction {
		return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
			.selectElement(with: matcher)
	}
	
	open class func setFailureHandler(handler: GREYFailureHandler, file: StaticString = #file, line: UInt = #line) {
		return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
			.setFailureHandler(handler)
	}
	
	open class func handle(exception: GREYFrameworkException, details: String, file: StaticString = #file, line: UInt = #line) {
		return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
			.handle(exception, details: details)
	}
	
	@discardableResult
	open class func rotateDeviceTo(orientation: UIDeviceOrientation, errorOrNil: UnsafeMutablePointer<NSError?>!, file: StaticString = #file, line: UInt = #line)
		-> Bool {
			return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
				.rotateDevice(to: orientation,
							  errorOrNil: errorOrNil)
	}
	
	/// Finds an element that fulfills `matcher` using an `action` on an element that fulfills `targetMatcher`.
	open class func element(with matcher: GREYMatcher, using action: GREYAction, on targetMatcher: GREYMatcher, file: StaticString = #file, line: UInt = #line) -> GREYInteraction {
		return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
			.selectElement(with: matcher)
			.atIndex(0)
			.using(searchAction: action, onElementWithMatcher: targetMatcher)
	}
	
	/// Scrolls a fixed `ammount` in the desired direction.
	public static func scroll(in direction: EarlGrey.ScrollDirection, amount: CGFloat) -> GREYAction {
		return grey_scrollInDirection(direction.toEarlGreyConstant, amount)
	}
	
	public static func scroll(to contentEdge: EarlGrey.ContentEdge) -> GREYAction {
		return grey_scrollToContentEdge(contentEdge.toEarlGreyConstant)
	}
	
	public static func element(_ matcher: EarlGrey.Matcher, file: StaticString = #file, line: UInt = #line) -> GREYInteraction {
		return EarlGreyImpl.invoked(fromFile: file.description, lineNumber: line)
			.selectElement(with: matcher.toEarlGrey)
	}
}

extension EarlGrey {
	
	static func that(_ condition: EarlGrey.Condition) -> Matcher {
		return Matcher.that(condition)
	}
	
	static func any(_ conditions: EarlGrey.Condition...) -> Matcher {
		return Matcher.any(conditions)
	}
	
	static func all(_ conditions: EarlGrey.Condition...) -> Matcher {
		return Matcher.all(conditions)
	}
	
	public enum Matcher {
		case that(EarlGrey.Condition)
		case any([EarlGrey.Condition])
		case all([EarlGrey.Condition])
		
		fileprivate var toEarlGrey: GREYMatcher {
			switch self {
			case .that(let condition):
				return condition.toEarlGrey
			case .any(let conditions):
				return grey_anyOf(conditions.map { $0.toEarlGrey })
			case .all(let conditions):
				return grey_allOf(conditions.map { $0.toEarlGrey })
			}
		}
		
		var occurrences: Int {
			return self.toEarlGrey.occurrences
		}
		
		public func selected(file: StaticString = #file, line: UInt = #line) -> GREYInteraction {
			return EarlGrey.element(self)
		}
	}
	
	public enum Condition {
		case accessibilityID(String)
		case accessibilityLabel(String)
		case interactable
		case enabled
		case hasText(String)
		case isNotVisible
		case kindOf(AnyClass)
		
		fileprivate var toEarlGrey: GREYMatcher {
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
	
	public enum Action {
		case scrollInDirection(EarlGrey.ScrollDirection, amount: CGFloat)
		case scrollToContentEdge(EarlGrey.ContentEdge)
		case tap
		
		fileprivate var toEarlGrey: GREYAction {
			switch self {
			case .scrollToContentEdge(let contentEdge):
				return EarlGrey.scroll(to: contentEdge)
			case .scrollInDirection(let direction, let amount):
				return EarlGrey.scroll(in: direction, amount: amount)
			case .tap:
				return grey_tap()
			}
		}
	}
}

extension EarlGrey {
	
	public enum ScrollDirection {
		// swiftlint:disable:next identifier_name
		case up
		case down
		case left
		case right
		
		fileprivate var toEarlGreyConstant: GREYDirection {
			switch self {
			case .up:
				return GREYDirection.up
			case .down:
				return GREYDirection.down
			case .left:
				return GREYDirection.left
			case .right:
				return GREYDirection.right
			}
		}
	}
	
	public enum ContentEdge {
		case top
		case bottom
		case left
		case right
		
		fileprivate var toEarlGreyConstant: GREYContentEdge {
			switch self {
			case .top:
				return GREYContentEdge.top
			case .bottom:
				return GREYContentEdge.bottom
			case .left:
				return GREYContentEdge.left
			case .right:
				return GREYContentEdge.right
			}
		}
	}
}

extension GREYInteraction {
	@discardableResult
	public func assert(_ matcher: @autoclosure () -> GREYMatcher) -> Self {
		return self.__assert(with: matcher())
	}
	
	@discardableResult
	public func assert(_ matcher: @autoclosure () -> GREYMatcher, error: UnsafeMutablePointer<NSError?>!) -> Self {
		return self.__assert(with: matcher(), error: error)
	}
	
	@available(*, deprecated, renamed: "assert(_:)")
	@discardableResult
	public func assert(with matcher: GREYMatcher!) -> Self {
		return self.__assert(with: matcher)
	}
	
	@available(*, deprecated, renamed: "assert(_:error:)")
	@discardableResult
	public func assert(with matcher: GREYMatcher!, error: UnsafeMutablePointer<NSError?>!) -> Self {
		return self.__assert(with: matcher, error: error)
	}
	
	@discardableResult
	public func perform(_ action: GREYAction!) -> Self {
		return self.__perform(action)
	}
	
	@discardableResult
	public func perform(_ action: GREYAction!, error: UnsafeMutablePointer<NSError?>!) -> Self {
		return self.__perform(action, error: error)
	}
	
	@discardableResult
	public func using(searchAction: GREYAction, onElementWithMatcher matcher: GREYMatcher) -> Self {
		return self.usingSearch(searchAction, onElementWith: matcher)
	}
	
	@discardableResult
	public func perform(_ action: GREYAction!,
						_ error: UnsafeMutablePointer<NSError?>!) -> Self {
		return self.__perform(action, error: error)
	}
	
	public func using(_ action: EarlGrey.Action, on matcher: EarlGrey.Matcher) -> Self {
		return self.using(searchAction: action.toEarlGrey, onElementWithMatcher: matcher.toEarlGrey)
	}
	
	public func at(_ index: UInt) -> Self {
		return self.atIndex(index)
	}
	
	@discardableResult
	public func assert(_ closure: (Self) -> Void) -> Self {
		closure(self)
		return self
	}
}

extension GREYCondition {
	open func waitWithTimeout(seconds: CFTimeInterval) -> Bool {
		return self.wait(withTimeout: seconds)
	}
	
	open func waitWithTimeout(seconds: CFTimeInterval, pollInterval: CFTimeInterval)
		-> Bool {
			return self.wait(withTimeout: seconds, pollInterval: pollInterval)
	}
}

extension GREYMatcher {
	
	/// The number of elements that satisfies the matcher.
	public var occurrences: Int {
		var error: NSError?
		var index: Int = 0
		let countMatcher: GREYElementMatcherBlock =
			GREYElementMatcherBlock.matcher(matchesBlock: { (element: Any) -> Bool in
				if self.matches(element) {
					index += 1
				}
				return false
				// swiftlint:disable:next multiple_closures_with_trailing_closure
			}) { (description: AnyObject?) in
				// swiftlint:disable:next force_cast
				let greyDescription: GREYDescription = description as! GREYDescription
				greyDescription.appendText("Count of Matcher")
		}
		EarlGrey.selectElement(with: countMatcher)
			.assert(grey_notNil(), error: &error)
		return index
	}
}
