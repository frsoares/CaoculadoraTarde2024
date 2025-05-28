//
//  UltimoCalculoWidget.swift
//  UltimoCalculoWidget
//
//  Created by Francisco Miranda Soares on 27/05/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    @AppStorage("resultado", store: UserDefaults(
        suiteName: "group.br.ufpe.cin.fmssn.CaoculadoraTarde"
    )) var result: Int?

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), result: 21)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), result: result ?? 21)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        if let result {
            let entry = SimpleEntry(date: .now, result: result)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let result: Int
}

struct UltimoCalculoWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack {
            Text("Último cálculo foi:")
                .font(font)
            Text("\(entry.result) anos!")
        }
    }

    var font: Font {
        if family == .systemSmall {
            return .title3
        } else {
            return .title
        }
    }
}

struct UltimoCalculoWidget: Widget {
    let kind: String = "UltimoCalculoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                UltimoCalculoWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                UltimoCalculoWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview("Pequeno", as: .systemSmall) {
    UltimoCalculoWidget()
} timeline: {
    SimpleEntry(date: .now, result: 23)
}

#Preview("Médio", as: .systemMedium) {
    UltimoCalculoWidget()
} timeline: {
    SimpleEntry(date: .now, result: 23)
}
