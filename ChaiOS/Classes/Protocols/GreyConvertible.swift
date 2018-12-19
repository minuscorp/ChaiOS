import Foundation
import EarlGrey

public protocol GreyConvertible {
    associatedtype Grey
    var toGrey: Grey { get }
}
