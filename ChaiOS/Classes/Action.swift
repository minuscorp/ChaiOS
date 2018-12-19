import Foundation
import EarlGrey

public enum Action {
    case scrollInDirection(Direction, amount: CGFloat)
    case scrollToContentEdge(ContentEdge)
    case tap
    case doubleTap
    case doubleTapAt(CGPoint)
    case multipleTapsWithCount(UInt)
    case longPress
    case longPressWithDuration(CFTimeInterval)
    case longPressAtPointWithDuration(point: CGPoint, duration: CFTimeInterval)
    case scrollInDirectionWithStartPoint(
        direction: Direction,
        amount: CGFloat,
        xOriginStartPercentage: CGFloat,
        yOriginStartPercentage: CGFloat)
    case scrollToContenEdgeWithStartPoint(
        contentEdge: ContentEdge,
        xOriginStartPercentage: CGFloat,
        yOriginStartPercentage: CGFloat)
    case swipeFastInDirection(Direction)
    case swipeSlowInDirection(Direction)
    case swipeFastInDirectionWithStartPoint(
        direction: Direction,
        xOriginStartPercentage: CGFloat,
        yOriginStartPercentage: CGFloat)
    case swipeSlowInDirectionWithStartPoint(
        direction: Direction,
        xOriginStartPercentage: CGFloat,
        yOriginStartPercentage: CGFloat)
    case multiFingerSwipeSlowInDirection(direction: Direction, numberOfFingers: UInt)
    case multiFingerSwipeFastInDirection(direction: Direction, numberOfFingers: UInt)
    case multiFingerSwipeSlowInDirectionWithStartPoint(
        direction: Direction,
        numberOfFingers: UInt,
        xOriginStartPercentage: CGFloat,
        yOriginStartPercetage: CGFloat)
    case multiFingerSwipeFastInDirectionWithStartPoint(Direction,
        numberOfFingers: UInt,
        xOriginStartPercentage: CGFloat,
        yOriginStartPercetage: CGFloat)
    case pinchFastInDirectionAndAngle(pinchDirection: PinchDirection, angle: Double)
    case pinchSlowInDirectionAndAngle(pinchDirection: PinchDirection, angle: Double)
    case moveSliderToValue(Float)
    case setStepperValue(Double)
    case tapAt(CGPoint)
    case type(String)
    case replaceText(String)
    case clearText
    case setDate(Date)
    case setPickerColumnToValue(column: Int, value: String)
    case javaScriptExecution(js: String, outResult: UnsafeMutablePointer<NSString?>?)
    case snapshot(outImage: UnsafeMutablePointer<UIImage?>?)
}

extension Action: GreyConvertible {
    public typealias Grey = GREYAction
    
    public var toGrey: GREYAction {
        switch self {
        case .tap:
            return grey_tap()
        case .scrollInDirection(let direction, let amount):
            return grey_scrollInDirection(direction.toGrey, amount)
        case .scrollToContentEdge(let contentEdge):
            return grey_scrollToContentEdge(contentEdge.toGrey)
        case .doubleTap:
            return grey_doubleTap()
        case .doubleTapAt(let point):
            return grey_doubleTapAtPoint(point)
        case .multipleTapsWithCount(let count):
            return grey_multipleTapsWithCount(count)
        case .longPress:
            return grey_longPress()
        case .longPressWithDuration(let duration):
            return grey_longPressWithDuration(duration)
        case .longPressAtPointWithDuration(let point, let duration):
            return grey_longPressAtPointWithDuration(point, duration)
        case .scrollInDirectionWithStartPoint(let direction, let amount, let xOriginStartPercentage, let yOriginStartPercentage):
            return grey_scrollInDirectionWithStartPoint(direction.toGrey, amount, xOriginStartPercentage, yOriginStartPercentage)
        case .scrollToContenEdgeWithStartPoint(let contentEdge, let xOriginStartPercentage, let yOriginStartPercentage):
            return grey_scrollToContentEdgeWithStartPoint(contentEdge.toGrey, xOriginStartPercentage, yOriginStartPercentage)
        case .swipeFastInDirection(let direction):
            return grey_swipeFastInDirection(direction.toGrey)
        case .swipeSlowInDirection(let direction):
            return grey_swipeSlowInDirection(direction.toGrey)
        case .swipeFastInDirectionWithStartPoint(let direction, let xOriginStartPercentage, let yOriginStartPercentage):
            return grey_swipeFastInDirectionWithStartPoint(direction.toGrey, xOriginStartPercentage, yOriginStartPercentage)
        case .swipeSlowInDirectionWithStartPoint(let direction, let xOriginStartPercentage, let yOriginStartPercentage):
            return grey_swipeSlowInDirectionWithStartPoint(direction.toGrey, xOriginStartPercentage, yOriginStartPercentage)
        case .multiFingerSwipeSlowInDirection(let direction, let numberOfFingers):
            return grey_multiFingerSwipeSlowInDirection(direction.toGrey, numberOfFingers)
        case .multiFingerSwipeFastInDirection(let direction, let numberOfFingers):
            return grey_multiFingerSwipeFastInDirection(direction.toGrey, numberOfFingers)
        case .multiFingerSwipeFastInDirectionWithStartPoint(let direction, let numberOfFingers, let xOriginStartPercentage, let yOriginStartPercetage):
            return grey_multiFingerSwipeFastInDirectionWithStartPoint(direction.toGrey, numberOfFingers, xOriginStartPercentage, yOriginStartPercetage)
        case .multiFingerSwipeSlowInDirectionWithStartPoint(let direction, let numberOfFingers, let xOriginStartPercentage, let yOriginStartPercetage):
            return grey_multiFingerSwipeSlowInDirectionWithStartPoint(direction.toGrey, numberOfFingers, xOriginStartPercentage, yOriginStartPercetage)
        case .pinchFastInDirectionAndAngle(let pinchDirection, let angle):
            return grey_pinchFastInDirectionAndAngle(pinchDirection.toGrey, angle)
        case .pinchSlowInDirectionAndAngle(let pinchDirection, let angle):
            return grey_pinchSlowInDirectionAndAngle(pinchDirection.toGrey, angle)
        case .moveSliderToValue(let value):
            return grey_moveSliderToValue(value)
        case .setStepperValue(let value):
            return grey_setStepperValue(value)
        case .tapAt(let point):
            return grey_tapAtPoint(point)
        case .type(let text):
            return grey_typeText(text)
        case .replaceText(let text):
            return grey_replaceText(text)
        case .clearText:
            return grey_clearText()
        case .setDate(let date):
            return grey_setDate(date)
        case .setPickerColumnToValue(let column, let value):
            return grey_setPickerColumnToValue(column, value)
        case .javaScriptExecution(let js, let outResult):
            return grey_javaScriptExecution(js, outResult)
        case .snapshot(let outImage):
            return grey_snapshot(outImage)
        }
    }
}
