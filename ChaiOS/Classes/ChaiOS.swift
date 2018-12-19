import Foundation
import EarlGrey

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
