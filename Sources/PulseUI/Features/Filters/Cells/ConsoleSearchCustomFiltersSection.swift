// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

#if os(iOS) || os(macOS)

import SwiftUI
import Pulse

@available(iOS 15, *)
struct ConsoleSearchCustomNetworkFiltersSection: View {
    @Binding var selection: ConsoleFilers.CustomNetworkFilters

    var body: some View {
        ForEach($selection.filters) { filter in
            ConsoleCustomNetworkFilterView(filter: filter, onRemove: selection.filters.count > 1  ? { remove(filter.wrappedValue) } : nil)
        }
        if !(selection == .init()) {
            Button(action: { selection.filters.append(.default) }) {
                Text("Add Filter")
            }
        }
    }

    private func remove(_ filter: ConsoleCustomNetworkFilter) {
        if let index = selection.filters.firstIndex(where: { $0.id == filter.id }) {
            selection.filters.remove(at: index)
        }
    }
}

@available(iOS 15, *)
struct ConsoleSearchCustomMessageFiltersSection: View {
    @Binding var selection: ConsoleFilers.CustomMessageFilters

    var body: some View {
        ForEach($selection.filters) { filter in
            ConsoleCustomMessageFilterView(filter: filter, onRemove: selection.filters.count > 1  ? { remove(filter.wrappedValue) } : nil)
        }
        if !(selection == .init()) {
            Button(action: { selection.filters.append(.default) }) {
                Text("Add Filter")
            }
        }
    }

    private func remove(_ filter: ConsoleCustomMessageFilter) {
        if let index = selection.filters.firstIndex(where: { $0.id == filter.id }) {
            selection.filters.remove(at: index)
        }
    }
}

#endif
