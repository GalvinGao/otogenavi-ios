//
//  ContentView.swift
//  OtogeNavi
//
//  Created by Galvin Gao on 5/27/24.
//

import ClusterMap
import ClusterMapSwiftUI
import Glur
import MapKit
import OtogeNaviAPI
import SwiftUI
import Toast

typealias Location = OtogeNaviAPI.ListLocationsQuery.Data.Locations.Edge.Node

struct ContentView: View {
    @State private var isLoading: Bool = false
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedPlaceId: String?
    @ObservedObject private var dataSource = DataSource()
    @Environment(\.colorScheme) var colorScheme
    @Namespace var mapScope

    let clusterManager = ClusterManager<Place>()

    private var selectedPlace: Place? {
        if let selectedPlaceId {
            return dataSource.annotations.first(where: { $0.id == selectedPlaceId })
        }
        return nil
    }

    // derive a Binding<Bool> based on selectedPlace is nil or not
    private var isPlaceSelected: Binding<Bool> {
        .init {
            selectedPlace != nil
        } set: { newValue in
            if !newValue {
                selectedPlaceId = nil
            }
        }
    }

    var body: some View {
        ZStack {
            Map(
                position: $position,
                interactionModes: [.pan, .zoom],
                selection: $selectedPlaceId,
                scope: mapScope
            ) {
                UserAnnotation()

                ForEach(dataSource.annotations) { item in
                    Marker(
                        item.location.name,
                        systemImage: "mappin",
                        coordinate: item.coordinate
                    )
                    .tag(item.id)
                }

                ForEach(dataSource.clusters) { item in
                    Marker(
                        "\(item.count)",
                        systemImage: "square.3.layers.3d",
                        coordinate: item.coordinate
                    )
                }
            }
            .mapControls {
                MapCompass()
            }
            .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .including([
                .airport, .publicTransport
            ])))
            .readSize(onChange: { newValue in
                dataSource.mapSize = newValue
            })
            .onMapCameraChange { context in
                dataSource.currentRegion = context.region.extend(by: 1.2)
            }
            .onMapCameraChange(frequency: .onEnd) { _ in
                Task.detached { await dataSource.reloadAnnotations() }
            }

            VStack {
                VariableBlurView(maxBlurRadius: 10)
                    .frame(height: 90)
                    .mask(
                        LinearGradient(stops: [
                            .init(color: .black.opacity(1), location: 0),
                            .init(color: .black.opacity(1), location: 0.7),
                            .init(color: .black.opacity(0), location: 1)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                    .allowsHitTesting(false)
                    // rerender the blur view when colorScheme changes
                    .id(colorScheme)

                Spacer()
            }
            .ignoresSafeArea()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .allowsHitTesting(false)
                .opacity(isLoading ? 1 : 0)
                .animation(.easeInOut, value: isLoading)

            Group {
                MapUserLocationButton(scope: mapScope)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.horizontal)
        }
        .overlay(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Text("音ゲーナビ")
                    .font(.headline.bold())

                Text("v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0")")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                MapScaleView(scope: mapScope)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .allowsHitTesting(false)
        }
        .mapScope(mapScope)
        .sheet(isPresented: isPlaceSelected) {
            Group {
                if let selectedPlace {
                    PlaceView(place: selectedPlace) {
                        selectedPlaceId = nil
                    }
                }
            }
            .presentationDetents([.fraction(0.35), .large])
            .presentationDragIndicator(.automatic)
            .presentationBackgroundInteraction(.enabled(upThrough: .large))
        }
        .onAppear {
            isLoading = true

            apolloClient.fetch(query: OtogeNaviAPI.ListLocationsQuery(), cachePolicy: .returnCacheDataAndFetch) { result in
                do {
                    defer {
                        isLoading = false
                    }
                    guard let data = try result.get().data?.locations.edges else { return }
                    let places = data.compactMap { $0?.node }.map { node in
                        Place(
                            id: node.id,
                            coordinate: node.coordinate?.coordinate ?? .init(),
                            location: node
                        )
                    }
                    Task {
                        await self.dataSource.addAnnotations(places: places)

                        Toast.default(
                            image: UIImage(systemName: "checkmark.circle.fill")!,
                            title: "データを読み込みました",
                            subtitle: "\(places.count)件のゲーセン情報を表示しています"
                        ).show()
                    }
                } catch {
                    print(error)
                }
            }

            LocationManager().checkLocationAuthorization()
        }
    }
}

#Preview {
    ContentView()
}
