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

let store = ApolloStore(cache: InMemoryNormalizedCache())
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
