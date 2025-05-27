//
//  UltimoCalculoWidget.swift
//  UltimoCalculoWidget
//
//  Created by Francisco Miranda Soares on 26/05/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    @AppStorage(
        "calculo",
        store: UserDefaults(
            suiteName: "group.br.ufpe.cin.fmssn.CaoculadoraTarde"
        )
    ) var result: Int?

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), result: 28)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let result = result ?? 28
        let entry = SimpleEntry(date: Date(), result: result)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        if let result {
            let entry = SimpleEntry(date: .now, result: result)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .never)
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

    var body: some View {
        VStack {
            Text("Último Cálculo!")
                .font(.title)
            Text("\(entry.result) anos!")
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

#Preview(as: .systemSmall) {
    UltimoCalculoWidget()
} timeline: {
    SimpleEntry(date: .now, result: 28)
    SimpleEntry(date: .now, result: 28)
}
