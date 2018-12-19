import Foundation
import EarlGrey

public enum PinchDirection {
    case outward
    case inward
}

extension PinchDirection: GreyConvertible {
    public typealias Grey = GREYPinchDirection
    
    public var toGrey: GREYPinchDirection {
        switch self {
        case .outward:
            return .outward
        case .inward:
            return .inward
        }
    }
}
