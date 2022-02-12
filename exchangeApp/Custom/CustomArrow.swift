//
//  CustomArrowView.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 12.02.2022.
//

import UIKit

class CustomArrow: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func draw(_ rect: CGRect) {
        let slashFirst = UIBezierPath()
        let width = self.frame.width
        let height = self.frame.height
        slashFirst.move(to: CGPoint(x: 2, y: 2))
        slashFirst.addLine(to: CGPoint(x: width/2, y: height - 2))
        UIColor.white.setStroke()

        let slashSecond = UIBezierPath()
        slashSecond.move(to: CGPoint(x: width/2, y: height - 2))
        slashSecond.addLine(to: CGPoint(x: width - 2, y: 2))
        UIColor.black.setStroke()

        slashFirst.lineCapStyle = .round
        slashSecond.lineCapStyle = .round
        slashFirst.lineWidth = 2.3
        slashSecond.lineWidth = 2.3
        slashFirst.stroke()
        slashSecond.stroke()
    }
}
