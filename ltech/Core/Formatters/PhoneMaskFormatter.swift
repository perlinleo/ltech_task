//
//  PhoneMaskFormatter.swift
//  ltech
//
//  Created by blacksnow on 5/18/25.
//

import Foundation

enum PhoneMaskFormatter {
    static func convertMask(_ mask: String?) -> String {
        guard let mask else { return "" }

        let pattern = "Х+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return mask
        }

        let nsRange = NSRange(mask.startIndex ..< mask.endIndex, in: mask)
        var result = mask
        let matches = regex.matches(in: mask, range: nsRange).reversed()

        for match in matches {
            if let range = Range(match.range, in: result) {
                let zeros = String(repeating: "0", count: match.range.length)
                result.replaceSubrange(range, with: "[\(zeros)]")
            }
        }

        return result
    }
}
