//
//  Extension.swift
//  FileOutput
//
//  Created by Jim Chuang on 2019/1/2.
//  Copyright © 2019 nhr. All rights reserved.
//

import Foundation
import UIKit



extension UIImage {

    func addText(drawText text: String, atPoint point: CGPoint, width: CGFloat = 1, height:CGFloat = 1) -> UIImage {
        let textColor = UIColor.black
        let textFont = UIFont(name: "Helvetica Bold", size: 15)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)

        let titleParagraphStyle = NSMutableParagraphStyle()

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: titleParagraphStyle
            ] as [NSAttributedString.Key : Any]
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))

        //let rect = CGRect(origin: point, size: image.size)
        var rect = CGRect(origin: point, size: CGSize(width: self.size.width*form.share.widthPoint*width, height: self.size.height*form.share.heightPoint*height))

        // 置底
        let textSize = text.size(withAttributes: textFontAttributes)
        rect.origin.y = rect.origin.y + (self.size.width*form.share.heightPoint*height - textSize.height)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}


class myTextField: UITextField {
    var indexPath:IndexPath?
}

extension Double {
    func toStr() -> String {
        return String(self)
    }
}
