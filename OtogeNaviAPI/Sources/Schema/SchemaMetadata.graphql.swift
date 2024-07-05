// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == OtogeNaviAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == OtogeNaviAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == OtogeNaviAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == OtogeNaviAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Query": return OtogeNaviAPI.Objects.Query
    case "LocationConnection": return OtogeNaviAPI.Objects.LocationConnection
    case "LocationEdge": return OtogeNaviAPI.Objects.LocationEdge
    case "Location": return OtogeNaviAPI.Objects.Location
    case "Cabinet": return OtogeNaviAPI.Objects.Cabinet
    case "Game": return OtogeNaviAPI.Objects.Game
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
