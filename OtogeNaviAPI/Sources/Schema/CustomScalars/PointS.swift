// @generated
// This file was automatically generated and can be edited to
// implement advanced custom scalar functionality.
//
// Any changes to this file will not be overwritten by future
// code generation execution.

import ApolloAPI
import MapKit

public struct PointCoordinate: CustomScalarType {
    let longitude: Double
    let latitude: Double

    // 1. Implement the _jsonValue property.
    public var _jsonValue: JSONValue {
        return ["longitude": longitude, "latitude": latitude]
    }

    // 2. Implement the init(_jsonValue:) initializer.
    public init(_jsonValue: JSONValue) throws {
        guard let jsonObject = _jsonValue as? [String: Double],
              let longitude = jsonObject["longitude"],
              let latitude = jsonObject["latitude"]
        else {
            throw JSONDecodingError.couldNotConvert(value: _jsonValue, to: PointCoordinate.self)
        }

        self.longitude = longitude
        self.latitude = latitude
    }
}

// 3. Implement the Hashable and Equatable protocols.
extension PointCoordinate: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(longitude)
        hasher.combine(latitude)
    }
}

public extension PointCoordinate {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

public typealias PointS = PointCoordinate
