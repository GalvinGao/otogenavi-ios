//
//  PlaceView.swift
//  OtogeNavi
//
//  Created by Galvin Gao on 5/28/24.
//

import ClusterMap
import MapKit
import SwifterSwift
import SwiftUI

struct Place: CoordinateIdentifiable, Identifiable, Equatable, Hashable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.id == rhs.id
    }

    let id: String
    var coordinate: CLLocationCoordinate2D
    let location: Location
}

struct PlaceView: View {
    var place: Place
    var onClose: (() -> Void)?

    var cabinets: [Location.Cabinet] {
        place.location.cabinets?.compactMap { $0 } ?? []
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(place.location.name)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .tracking(-0.75)
                            // select and copiable
                            .textSelection(.enabled)

                        Text(place.location.rawAddress ?? "Unknown")
                            .font(.caption2)
                            .tracking(-0.75)
                            .textSelection(.enabled)
                    }

                    Spacer()

                    Button {
                        onClose?()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(.ultraThinMaterial)
                    }
                    .clipShape(Circle())
                }

                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            guard let url = URL(string: "maps://?q=\(place.location.name.urlEncoded)&ll=\(place.coordinate.latitude),\(place.coordinate.longitude)") else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            VStack {
                                Image(systemName: "signpost.right.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)

                                Text("Navigate")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .tracking(-0.5)
                            }
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }

                        Button {
                            guard let url = URL(string: "https://www.google.com/search?q=\(place.location.name.urlEncoded)") else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            VStack {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 20, height: 20)

                                Text("Search on Google")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .tracking(-0.5)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                        }
                    }
                }

                Divider()

                Text("Cabinets")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .tracking(-0.5)

                LazyVGrid(columns: [
                    GridItem(), GridItem(),
                ]) {
                    ForEach(cabinets, id: \.id) { cabinet in
                        VStack(alignment: .leading, spacing: 0) {
                            Text(cabinet.game.name)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .tracking(-0.5)

                            Spacer()

                            HStack {
                                if cabinet.count != nil && cabinet.count ?? 0 > 0 {
                                    Text(cabinet.count?.string ?? "")
                                        .font(.largeTitle)
                                        .foregroundStyle(.secondary)
                                        .tracking(-0.5)
                                }

                                Spacer()

                                Image(systemName: "dpad")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.secondary)
                                    .padding(8)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#Preview {
    PlaceView(
        place: .init(id: "loc_test",
                     coordinate: .init(),
                     location: try! .init(data: [
                         "__typename": "Location",
                         "id": "loc_test",
                         "name": "東京ビッグサイト",
                         "rawAddress": "コンベンションセンター",
                         "cabinets": [
                             ["__typename": "Cabinet",
                              "id": "cab_test",
                              "game": [
                                  "__typename": "Game",
                                  "id": "gam_1",
                                  "name": "beatmania IIDX 28 BISTROVER",
                              ]],
                             ["__typename": "Cabinet",
                              "id": "cab_test2",
                              "count": 1,
                              "game": [
                                  "__typename": "Game",
                                  "id": "gam_2",
                                  "name": "CHUNITHM",
                              ]],
                         ],
                     ])))
}
