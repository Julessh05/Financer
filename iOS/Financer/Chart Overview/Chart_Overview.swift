//
//  Chart_Overview.swift
//  Chart Overview
//
//  Created by Julian Schumacher on 24.04.23.
//

import WidgetKit
import SwiftUI
import Intents

private struct Provider : IntentTimelineProvider {
    typealias Entry = <#type#>
    
    typealias Intent = <#type#>
    
    func getTimeline(for configuration: Intent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        <#code#>
    }
}

internal struct Chart_Overview: Widget {
    let kind: String = "Chart_Overview"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) {
            entry in
            ChartOverviewBody()
        }
        .configurationDisplayName("Chart Overview")
        .description("Display an overview of your finances as a chart")
    }
}

private struct ChartOverviewBody : View {
    
    var body: some View {
        return Text("Test")
    }
    
}

internal struct Chart_Overview_Previews: PreviewProvider {
    static var previews: some View {
        ChartOverviewBody()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
