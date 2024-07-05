// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ListLocationsQuery: GraphQLQuery {
  public static let operationName: String = "ListLocations"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    operationIdentifier: "71a7517721ced8c925a1f73d185129592d6cf6636fc59057b40f2508dc5b23e9",
    definition: .init(
      #"query ListLocations { locations { __typename edges { __typename node { __typename id coordinate name rawAddress cabinets { __typename id count game { __typename id name } } } } } }"#
    ))

  public init() {}

  public struct Data: OtogeNaviAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { OtogeNaviAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("locations", Locations.self),
    ] }

    public var locations: Locations { __data["locations"] }

    /// Locations
    ///
    /// Parent Type: `LocationConnection`
    public struct Locations: OtogeNaviAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { OtogeNaviAPI.Objects.LocationConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge?]?.self),
      ] }

      /// A list of edges.
      public var edges: [Edge?]? { __data["edges"] }

      /// Locations.Edge
      ///
      /// Parent Type: `LocationEdge`
      public struct Edge: OtogeNaviAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { OtogeNaviAPI.Objects.LocationEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node?.self),
        ] }

        /// The item at the end of the edge.
        public var node: Node? { __data["node"] }

        /// Locations.Edge.Node
        ///
        /// Parent Type: `Location`
        public struct Node: OtogeNaviAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { OtogeNaviAPI.Objects.Location }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", OtogeNaviAPI.ID.self),
            .field("coordinate", OtogeNaviAPI.PointS?.self),
            .field("name", String.self),
            .field("rawAddress", String?.self),
            .field("cabinets", [Cabinet]?.self),
          ] }

          public var id: OtogeNaviAPI.ID { __data["id"] }
          public var coordinate: OtogeNaviAPI.PointS? { __data["coordinate"] }
          public var name: String { __data["name"] }
          public var rawAddress: String? { __data["rawAddress"] }
          public var cabinets: [Cabinet]? { __data["cabinets"] }

          /// Locations.Edge.Node.Cabinet
          ///
          /// Parent Type: `Cabinet`
          public struct Cabinet: OtogeNaviAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { OtogeNaviAPI.Objects.Cabinet }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", OtogeNaviAPI.ID.self),
              .field("count", Int?.self),
              .field("game", Game.self),
            ] }

            public var id: OtogeNaviAPI.ID { __data["id"] }
            public var count: Int? { __data["count"] }
            public var game: Game { __data["game"] }

            /// Locations.Edge.Node.Cabinet.Game
            ///
            /// Parent Type: `Game`
            public struct Game: OtogeNaviAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { OtogeNaviAPI.Objects.Game }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", OtogeNaviAPI.ID.self),
                .field("name", String.self),
              ] }

              public var id: OtogeNaviAPI.ID { __data["id"] }
              public var name: String { __data["name"] }
            }
          }
        }
      }
    }
  }
}
