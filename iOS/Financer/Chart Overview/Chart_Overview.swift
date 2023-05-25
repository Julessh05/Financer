//
//  Chart_Overview.swift
//  Chart Overview
//
//  Created by Julian Schumacher on 25.05.23.
//

import WidgetKit
import SwiftUI

internal struct Provider: TimelineProvider {
    
    fileprivate static let mockData : [(date : Date, amount : Double)] = [(Date(), 10)]
    
    private let mockEntry : BalancesEntry = BalancesEntry(date: Date(), values: Provider.mockData)
    
    internal func placeholder(in context: Context) -> BalancesEntry {
        mockEntry
    }

    internal func getSnapshot(in context: Context, completion: @escaping (BalancesEntry) -> ()) {
        let entry : BalancesEntry
        if context.isPreview {
            entry = mockEntry
        } else {
            entry = BalancesEntry(date: Date(), values: getMap())
        }
        completion(entry)
    }

    internal func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<BalancesEntry>
        ) -> ()
    ) {
        let timeline = Timeline(
            entries: [
                BalancesEntry(
                    date: Date(),
                    values: getMap()
                )
            ],
            policy: .after(
                Calendar.current.date(
                    byAdding: .minute,
                    value: 10,
                    to: Date()
                )!
            )
        )
        completion(timeline)
    }
    
    private func getMap() -> [(date : Date, amount : Double)] {
        return Provider.mockData
    }
}

internal struct BalancesEntry: TimelineEntry {
    internal let date: Date
    internal let values : [(date : Date, amount : Double)]
}

internal struct Chart_Overview: Widget {
    private let kind: String = "Chart_Overview"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            Chart_OverviewEntryView(entry: entry)
        }
        .configurationDisplayName("Balances Overview")
        .description("Display a Chart Overview over your Finances")
    }
}

internal struct Chart_OverviewEntryView : View {
    fileprivate let entry : BalancesEntry

    var body: some View {
        BalancesChart(balances: entry.values)
    }
}

internal struct Chart_Overview_Previews: PreviewProvider {
    internal static var previews: some View {
        Chart_OverviewEntryView(
            entry: BalancesEntry(
                date: Date(),
                values: Provider.mockData
            )
        )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
