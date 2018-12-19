import Foundation
import EarlGrey

public enum ContentEdge {
    case top
    case bottom
    case left
    case right
}

extension ContentEdge: GreyConvertible {
    public typealias Grey = GREYContentEdge
    
    public var toGrey: GREYContentEdge {
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
