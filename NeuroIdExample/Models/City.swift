import Foundation

struct City: Equatable {
    let city_id : String
    let city_name : String
    
    static func ==(lhs: City, rhs: City) -> Bool {
        let areEqual = lhs.city_id == rhs.city_id
        return areEqual
    }
}
