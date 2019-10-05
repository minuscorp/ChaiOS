import Foundation
import EarlGrey

public enum Direction {
    case up
    case down
    case left
    case right
}

extension Direction: GreyConvertible {
    
    public typealias Grey = GREYDirection
    
    public var toGrey: GREYDirection {
        switch self {
        case .up:
            return .up
        case .down:
            return .down
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}
