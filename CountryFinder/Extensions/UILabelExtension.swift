//
//  UILabelExtension.swift
//  CountryFinder
//
//  Created by Daniel Duran Schutz on 23/06/21.
//

import Foundation
import UIKit

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 1.0) {
        if let labelText = text, labelText.count > 0 {
          let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
          attributedText = attributedString
        }
    }
    
    func calculateMaxLines(actualWidth: CGFloat?) -> Int {
            var width = frame.size.width
            if let actualWidth = actualWidth {
                width = actualWidth
            }
            let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
            let charSize = font.lineHeight
            let text = (self.text ?? "") as NSString
            let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            let linesRoundedUp = Int(ceil(textSize.height/charSize))
            return linesRoundedUp
        }

    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    
    var actualNumberOfLines: Int {
            let textStorage = NSTextStorage(attributedString: self.attributedText!)
            let layoutManager = NSLayoutManager()
            textStorage.addLayoutManager(layoutManager)
            let textContainer = NSTextContainer(size: self.bounds.size)
            textContainer.lineFragmentPadding = 0
            textContainer.lineBreakMode = self.lineBreakMode
            layoutManager.addTextContainer(textContainer)

            let numberOfGlyphs = layoutManager.numberOfGlyphs
            var numberOfLines = 0, index = 0, lineRange = NSMakeRange(0, 1)

            while index < numberOfGlyphs {
                layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
                index = NSMaxRange(lineRange)
                numberOfLines += 1
            }
            return numberOfLines
        }
}
