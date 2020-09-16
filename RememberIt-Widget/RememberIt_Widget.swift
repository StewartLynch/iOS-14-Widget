//
//  RememberIt_Widget.swift
//  RememberIt-Widget
//
//  Created by Stewart Lynch on 2020-09-15.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import WidgetKit
import SwiftUI

struct RememberItEntry: TimelineEntry {
    let date: Date = Date()
    let rememberItem: RememberItem
}

struct Provider: TimelineProvider {
    @AppStorage("rememberItem", store: UserDefaults(suiteName: "group.com.createchsol.IRemember")) var primaryItemData: Data = Data()
    func placeholder(in context: Context) -> RememberItEntry {
        let rememberItem = RememberItem(title: "Rental SUV", icon: "car", detail1: "749 AAP", detail2: "Gray Ford Echo Sport")
        return RememberItEntry(rememberItem: rememberItem)
    }

    func getSnapshot(in context: Context, completion: @escaping (RememberItEntry) -> ()) {
        guard let rememberItem = try? JSONDecoder().decode(RememberItem.self, from: primaryItemData) else {
            print("Unable to decode primary item.")
            return
        }
        let entry = RememberItEntry(rememberItem: rememberItem)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        guard let rememberItem = try? JSONDecoder().decode(RememberItem.self, from: primaryItemData) else {
            print("Unable to decode primary item.")
            return
        }
        let entry = RememberItEntry(rememberItem: rememberItem)

        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}


struct RememberIt_WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        if family == .systemSmall {
            SmallWidget(entry: entry)
        } else {
            MediumWidget(entry: entry)
        }
    }
}

struct SmallWidget: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(entry.rememberItem.icon)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                Text(entry.rememberItem.title)
                    .font(.headline)
            }
            Text(entry.rememberItem.detail1).font(.title)
                .layoutPriority(1)
            Text(entry.rememberItem.detail2).font(.body)
            Spacer()
        }
        .padding(5)
    }
}

struct MediumWidget: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(entry.rememberItem.icon)
                    .resizable()
                    .frame(width: 125, height: 125)
                    .foregroundColor(.red)
                VStack(alignment: .leading) {
                        Text(entry.rememberItem.title)
                            .font(.title)
                    Text(entry.rememberItem.detail1).font(.largeTitle)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Text(entry.rememberItem.detail2).font(.body)
            Spacer()
        }.padding()
    }
}

@main
struct RememberIt_Widget: Widget {
    let kind: String = "RememberIt_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RememberIt_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("I Remember")
        .description("These are the I Remember Widgets.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct RememberIt_Widget_Previews: PreviewProvider {
    static  let rememberItem = RememberItem(title: "Rental SUV", icon: "car", detail1: "749 AAP", detail2: "Gray Ford Echo Sport")
    static var previews: some View {
        Group {
        RememberIt_WidgetEntryView(entry: RememberItEntry(rememberItem: rememberItem))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            RememberIt_WidgetEntryView(entry: RememberItEntry(rememberItem: rememberItem))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
