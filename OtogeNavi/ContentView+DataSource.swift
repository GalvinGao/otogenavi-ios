//
//  ContentView+DataSource.swift
//  OtogeNavi
//
//  Created by Galvin Gao on 5/29/24.
//

import ClusterMap
import Foundation
import MapKit

extension ContentView {
    struct ClusterAnnotation: Identifiable, Equatable {
        var id: UUID
        var coordinate: CLLocationCoordinate2D
        var count: Int

        // rewrite equatable to use coordinate + count for comparison because the ID has been
        // regenerated every time the cluster is reloaded
        static func == (lhs: ClusterAnnotation, rhs: ClusterAnnotation) -> Bool {
            lhs.coordinate == rhs.coordinate && lhs.count == rhs.count
        }
    }

    final class DataSource: ObservableObject {
        private let clusterManager = ClusterManager<Place>(
            configuration: ClusterManager.Configuration(
                maxZoomLevel: 14,
                clusterPosition: .center
            )
        )


        @Published var annotations: [Place] = []
        @Published var clusters: [ClusterAnnotation] = []

        var mapSize: CGSize = .zero
        var currentRegion: MKCoordinateRegion = .init()

        func addAnnotations(places: [Place]) async {
            await clusterManager.add(places)
            await reloadAnnotations()
        }

        func removeAnnotations() async {
            await clusterManager.removeAll()
            await reloadAnnotations()
        }

        func reloadAnnotations() async {
            async let changes = clusterManager.reload(mapViewSize: mapSize, coordinateRegion: currentRegion)
            await applyChanges(changes)
        }

        @MainActor
        private func applyChanges(_ difference: ClusterManager<Place>.Difference) {
            var copiedAnnotations = annotations.map { $0 }
            var copiedClusters = clusters.map { $0 }

            for removal in difference.removals {
                switch removal {
                case .annotation(let annotation):
                    copiedAnnotations.removeAll { $0 == annotation }
                case .cluster(let clusterAnnotation):
                    copiedClusters.removeAll { $0.id == clusterAnnotation.id }
                }
            }
            for insertion in difference.insertions {
                switch insertion {
                case .annotation(let newItem):
                    copiedAnnotations.append(newItem)
                case .cluster(let newItem):
                    copiedClusters.append(ClusterAnnotation(
                        id: newItem.id,
                        coordinate: newItem.coordinate,
                        count: newItem.memberAnnotations.count
                    ))
                }
            }

            // compare if the annotations are the same, and if so skip the `set` operation
            if copiedAnnotations != annotations {
                annotations = copiedAnnotations
            }
            if copiedClusters != clusters {
                clusters = copiedClusters
            }
        }
    }
}
