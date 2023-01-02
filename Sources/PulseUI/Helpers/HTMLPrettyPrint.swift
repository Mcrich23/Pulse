// The MIT License (MIT)
//
// Copyright (c) 2020–2022 Alexander Grebenyuk (github.com/kean).

#if !os(watchOS)

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

final class HTMLPrettyPrint {
    private let string: String
    private let fontSize: CGFloat

    init(string: String, fontSize: Int = Int(FontSize.body)) {
        self.string = string
        self.fontSize = CGFloat(fontSize)
    }

    func render() -> NSAttributedString {
        let text = NSMutableAttributedString(string: string)

        let ps = NSMutableParagraphStyle()
        ps.minimumLineHeight = fontSize + 5
        ps.maximumLineHeight = fontSize + 5

        text.addAttributes([
            .font: UXFont.monospacedSystemFont(ofSize: CGFloat(fontSize), weight: .regular),
            .foregroundColor: UXColor.label,
            .paragraphStyle: ps
        ])

        func makeRange(from substring: Substring) -> NSRange {
            NSRange(substring.startIndex..<substring.endIndex, in: string)
        }

        let tagRegex = try! Regex("<[^>]*>")
        let attributesRegex = try! Regex(#"(\w*?)=(\"\w.*?\")"#)
        for match in tagRegex.matches(in: string) {
            let range = makeRange(from: match.fullMatch)
            text.addAttribute(.foregroundColor, value: Palette.pink, range: range)
            for match in attributesRegex.matches(in: string, range: range) {
                if match.groups.count == 2 {
                    text.addAttribute(.foregroundColor, value: UXColor.systemOrange, range: makeRange(from: match.groups[0]))
                    text.addAttribute(.foregroundColor, value: UXColor.systemRed, range: makeRange(from: match.groups[1]))
                }
            }
        }
        return text
    }
}

#endif
