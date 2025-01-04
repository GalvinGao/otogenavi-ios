//
//  OtogeNaviApp.swift
//  OtogeNavi
//
//  Created by Galvin Gao on 5/27/24.
//

import Apollo
import Foundation
import OtogeNaviAPI
import SwiftUI

func getApolloCache() -> NormalizedCache {
    if let cache = try? SQLiteNormalizedCache(fileURL: .cachesDirectory.appending(path: "apollo.sqlite")) {
        return cache
    }
    return InMemoryNormalizedCache()
}

let store = ApolloStore(cache: getApolloCache())
let interceptorProvider = DefaultInterceptorProvider(store: store)
let networkTransport = RequestChainNetworkTransport(
    interceptorProvider: interceptorProvider,
    endpointURL: URL(string: "https://otogenavi.imgg.dev/graphql")!,
    autoPersistQueries: true
)

let apolloClient = ApolloClient(networkTransport: networkTransport, store: store)

@main
struct OtogeNaviApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
