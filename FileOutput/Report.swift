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

    func iSFullCondition() -> Bool{

        if myTotalArr.contains(where: {$0 == nil}){
            return false
        }
        /*
        if titleCustom == nil || titleModelName == nil || titleProjectNo == nil || titleActor == nil{
            return false
        }

        if specCenterFrequency == nil || specCenterCL == nil || specMaxESR == nil || specSealType == nil || specPackageSize == nil{
            return false
        }

        if unitFL == nil || unitC0 == nil || unitC1 == nil || unitRR == nil || unitTS == nil{
            return false
        }

        if measureFreq == nil || measureNR == nil || measureCurrent == nil {
            return false
        }
*/
        return true
    }

    var myTotalArr:Array<Any?>{
        get{
            return [
                titleCustom,titleModelName,titleProjectNo,titleActor,
                specCenterFrequency,specMaxESR,specCenterCL,specPackageSize,specSealType,
                unitFL,unitC0,unitC1,unitRR,unitTS,
                measureFreq,measureNR,measureCurrent]
        }
        set{
            titleCustom             = newValue[0]  as? String
            titleModelName          = newValue[1]  as? String
            titleProjectNo          = newValue[2]  as? String
            titleActor              = newValue[3]  as? String
            specCenterFrequency     = newValue[4]  is String ? Double(newValue[4] as! String) : specCenterFrequency
            specMaxESR              = newValue[5]  is String ? Double(newValue[5] as! String) : specMaxESR
            specCenterCL            = newValue[6]  is String ? Double(newValue[6] as! String) : specCenterCL
            specPackageSize         = newValue[7]  as? String
            specSealType            = newValue[8]  as? String
            unitFL                  = newValue[9]  is String ? Double(newValue[9]  as! String) : unitFL
            unitC0                  = newValue[10] is String ? Double(newValue[10] as! String) : unitC0
            unitC1                  = newValue[11] is String ? Double(newValue[11] as! String) : unitC1
            unitRR                  = newValue[12] is String ? Double(newValue[12] as! String) : unitRR
            unitTS                  = newValue[13] is String ? Double(newValue[13] as! String) : unitTS
            measureFreq             = newValue[14] is String ? Double(newValue[14] as! String) : measureFreq
            measureNR               = newValue[15] is String ? Double(newValue[15] as! String) : measureNR
            measureCurrent          = newValue[16] is String ? Double(newValue[16] as! String) : measureCurrent
        }
    }


    //MARK: - title
    private var titleCustom:String? = nil
    private var titleModelName:String? = nil
    private var titleProjectNo:String? = nil
    private var titleActor:String? = nil

    var title:(custom:String?,modelName:String?,projectNo:String?,actor:String?){
        get{
            return (titleCustom,titleModelName,titleProjectNo,titleActor)
        }
        set{
            titleCustom = newValue.custom
            titleModelName = newValue.modelName
            titleProjectNo = newValue.projectNo
            titleActor = newValue.actor
        }
    }


    //MARK: - spec
    private var specCenterFrequency:Double? = nil
    private var specMaxESR:Double? = nil
    private var specCenterCL:Double? = nil
    private var specPackageSize:String? = nil
    private var specSealType:String? = nil

    var spec:(centerFreq:Double?,maxESR:Double?,centerCL:Double?,packageSize:String?,sealType:String?){
        get{
            return (specCenterFrequency,specMaxESR,specCenterCL,specPackageSize,specSealType)
        }
        set{
            specCenterFrequency = newValue.centerFreq
            specMaxESR = newValue.maxESR
            specCenterCL = newValue.centerCL
            specPackageSize = newValue.packageSize
            specSealType = newValue.sealType
        }
    }


    //MARK: - unit
    private var unitFL:Double? = nil
    private var unitC0:Double? = nil
    private var unitC1:Double? = nil
    private var unitRR:Double? = nil
    private var unitTS:Double? = nil

    var unit:(fl:Double?,c0:Double?,c1:Double?,rr:Double?,ts:Double?){
        get{
            return (unitFL,unitC0,unitC1,unitRR,unitTS)
        }
        set{
            unitFL = newValue.fl
            unitC0 = newValue.c0
            unitC1 = newValue.c1
            unitRR = newValue.rr
            unitTS = newValue.ts
        }
    }


    //MARK: - measure
    private var measureFreq:Double? = nil
    private var measureNR:Double? = nil
    private var measureCurrent:Double? = nil

    var measure:(frequency:Double?,negativeResistance:Double?,current:Double?){
        get{
            return (measureFreq,measureNR,measureCurrent)
        }
        set{
            measureFreq = newValue.frequency
            measureNR = newValue.negativeResistance
            measureCurrent = newValue.current
        }
    }


    //MARK: - pic
    private var picSelfIn:UIImage? = nil
    private var picSelfOut:UIImage? = nil
    private var picSelfCur:UIImage? = nil
    private var picOtherIn:UIImage? = nil
    private var picOtherOut:UIImage? = nil
    private var picOtherCur:UIImage? = nil

    
    //MARK: - result
    var result:(shiftFL:String?,driveLevel:String?,nrRate:String?){
        get{
            return (resultFL,resultDL,resultNRRate)
        }
    }

    private var resultFL: String? {
        get {
            if let centerF = specCenterFrequency, let FL = unitFL, let mF = measureFreq{
                let percent = (mF - centerF) / centerF
                let ppm = percent * pow(10, 6)
                let shift = ppm - FL
                return String(format: "%.2f", shift)
            }else{
                return nil
            }
        }
    }

    private var resultDL: String?{
        get{
            if let rr = unitRR, let mCur = measureCurrent{
                let dl = pow(mCur, 2) * rr
                return String(format: "%.2f", dl)
            }else{
                return nil
            }
        }
    }

    private var resultNRRate: String?{
        get{
            if let rr = unitRR, let maxESR = specMaxESR, let mNr = measureNR{
                let nr = mNr + rr
                let rate = nr / (maxESR)
                return String(format: "%.2f", rate)
            }else{
                return nil
            }
        }
    }

    var arr:Array<String>{
        get{
            return [
                "客戶",
                "專案名稱",
                "報告編號",
                "作者",
                "中心頻率",
                "max ESR",
                "負載電容",
                "尺寸",
                "類型",
                "單體FL",
                "單體C0",
                "單體C1",
                "單體RR",
                "單體TS",
                "量測頻率",
                "負性阻抗",
                "量測電流"
            ]
        }
    }

    private var dic:Dictionary<String,String>{
        get{
            return [
                
                "titleCustom"           :"客戶",
                "titleModelName"        :"專案名稱",
                "titleProjectNo"        :"報告編號",
                "titleActor"            :"作者",

                "specCenterFrequency"   :"中心頻率",
                "specMaxESR"            :"max ESR",
                "specCenterCL"          :"負載電容",
                "specPackageSize"       :"尺寸",
                "specSealType"          :"類型",

                "unitFL"                :"單體FL",
                "unitC0"                :"單體C0",
                "unitC1"                :"單體C1",
                "unitRR"                :"單體RR",
                "unitTS"                :"單體TS",

                "measureFreq"           :"量測頻率",
                "measureNR"             :"負性阻抗",
                "measureCurrent"        :"量測電流"
            ]
        }
    }

}
