//
//  Report.swift
//  FileOutput
//
//  Created by Jim Chuang on 2018/12/27.
//  Copyright © 2018 nhr. All rights reserved.
//

import Foundation
import UIKit

class Report {
    static let share = Report()

    // basic
    var centerFrequency:Float? = nil
    var maxESR:Float? = nil
    var centerCL:Float? = nil
    var packageSize:String = ""
    var sealType:String = ""

    // unit
    var unitFL:Float? = nil
    var unitC0:Float? = nil
    var unitC1:Float? = nil
    var unitRR:Float? = nil
    var unitTS:Float? = nil

    // measure
    var measureFreq:Float? = nil
    var measureNR:Float? = nil
    var measureCur:Float? = nil

    // pic
    var picSelfIn:UIImage? = nil
    var picSelfOut:UIImage? = nil
    var picSelfCur:UIImage? = nil
    var picOtherIn:UIImage? = nil
    var picOtherOut:UIImage? = nil
    var picOtherCur:UIImage? = nil

    var resultFL: Float? {
        get {
            if let centerF = centerFrequency, let FL = unitFL, let mF = measureFreq{
                let percent = (mF - centerF) / mF
                let ppm = percent * powf(10, 6)
                let shift = ppm - FL
                return shift
            }else{
                return nil
            }
        }
    }

    var resultDL: Float?{
        get{
            if let rr = unitRR, let mCur = measureCur{
                let dl = powf(mCur, 2) * rr
                return dl
            }else{
                return nil
            }
        }
    }

    var resultNRRate: Float?{
        get{
            if let rr = unitRR, let maxESR = maxESR, let mNr = measureNR{
                let nr = mNr + rr
                let rate = nr / (maxESR)
                return rate
            }else{
                return nil
            }
        }
    }

}
