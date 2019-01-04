//
//  PDF.swift
//  FileOutput
//
//  Created by Jim Chuang on 2018/12/21.
//  Copyright © 2018 nhr. All rights reserved.
//

import Foundation
import PDFGenerator
import PDFReader


func generteMyImgPDF(imgArr:[UIImage]){
    var pages = Array<PDFPage>()
    for image in imgArr{
        let page = PDFPage.image(image)
        pages.append(page)
    }
    if pages.count > 0 {
        let path = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        do {
            try PDFGenerator.generate(pages, to: path)
        }catch (let error){
            print("image error = ",error)
        }
    }
}

func generateMyPDF(view:[UIView]){
    var pages = Array<PDFPage>()
    for myView in view{
        let page = PDFPage.view(myView)
        pages.append(page)
    }
    if pages.count > 0{
        let path = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        print("my gen Path = ",path)
        //let path = URL(fileURLWithPath: "/Users/jimchuang/sample1.pdf")
        do {
            try PDFGenerator.generate(pages, to: path)
        }catch (let error){
            print("error = ",error)
        }
    }
}

// Use PDFPage
func generatePDFPage() {
    let v1 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 100.0))
    v1.backgroundColor = .red
    let v2 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 200.0))
    v2.backgroundColor = .green

    let page1 = PDFPage.view(v1)
    let page2 = PDFPage.view(v2)
    let page3 = PDFPage.whitePage(CGSize(width: 200, height: 100))
    let page4 = PDFPage.image(UIImage(named: "image1.png")!)
    let page5 = PDFPage.image(UIImage(named: "image2.png")!)

    let pages = [page1, page2, page3, page4, page5]

    //let dst = NSTemporaryDirectory().appending("sample1.pdf")
    let dst = URL(fileURLWithPath: "/Users/jimchuang/sample1.pdf")
    print(dst)
    do {
        try PDFGenerator.generate(pages, to: dst)
    } catch (let e) {
        print(e)
    }
}

//UIView → PDF
func generateUIViewPDF() {
    let v1 = UIScrollView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 100.0))
    let v2 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 200.0))
    let v3 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 200.0))
    v1.backgroundColor = .red
    v1.contentSize = CGSize(width: 100.0, height: 200.0)
    v2.backgroundColor = .green
    v3.backgroundColor = .blue

    let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
    // outputs as Data
    do {
        let data = try PDFGenerator.generated(by: [v1, v2, v3])
        try data.write(to: dst, options: .atomic)
    } catch (let error) {
        print("error1 = ",error)
    }

    // writes to Disk directly.
    do {
        try PDFGenerator.generate([v1, v2, v3], to: dst)
    } catch (let error) {
        print("error2 = ",error)
    }


}

func imageArrToPDF(arr:Array<UIImage>){
    generteMyImgPDF(imgArr: arr)
}

func createTitleImg(custom:String,modelName:String,projectNo:String,actor:String) -> UIImage?{

    if var image = UIImage(named: "title.png"){
        let w = image.size.width
        let h = image.size.height

        let x1 = w * form.share.widthPoint * 3
        let x2 = w * form.share.widthPoint * 4
        let y1 = h * form.share.heightPoint * 8
        let y2 = h * form.share.heightPoint * 9
        let y3 = h * form.share.heightPoint * 10
        let y4 = h * form.share.heightPoint * 17

        image = image.addText(drawText: custom, atPoint: CGPoint(x: x1, y: y1), width: 2, height: 1)
        image = image.addText(drawText: modelName, atPoint: CGPoint(x: x1, y: y2), width: 2, height: 1)
        image = image.addText(drawText: projectNo, atPoint: CGPoint(x: x1, y: y3), width: 2, height: 1)
        image = image.addText(drawText: actor, atPoint: CGPoint(x: x2, y: y4), width: 1, height: 1)

        return image

    }else{
        return nil
    }
}

func createSpecImg(cl:String,freq:String,maxESR:String,size:String,type:String) -> UIImage?{

    if var image = UIImage(named: "spec.png"){
        let w = image.size.width
        let h = image.size.height

        let clX = w * form.share.widthPoint * 3
        let clY = h * form.share.heightPoint * 3
        let freqX = w * form.share.widthPoint * 3
        let freqY = h * form.share.heightPoint * 4
        let maxESRX = w * form.share.widthPoint * 3
        let maxESRY = h * form.share.heightPoint * 5
        let sizeX = w * form.share.widthPoint * 3
        let sizeY = h * form.share.heightPoint * 6
        let typeX = w * form.share.widthPoint * 3
        let typeY = h * form.share.heightPoint * 7

        image = image.addText(drawText: cl,         atPoint: CGPoint(x: clX, y: clY), width: 2, height: 1)
        image = image.addText(drawText: freq,       atPoint: CGPoint(x: freqX, y: freqY), width: 2, height: 1)
        image = image.addText(drawText: maxESR,     atPoint: CGPoint(x: maxESRX, y: maxESRY), width: 2, height: 1)
        image = image.addText(drawText: size,       atPoint: CGPoint(x: sizeX, y: sizeY), width: 2, height: 1)
        image = image.addText(drawText: type,       atPoint: CGPoint(x: typeX, y: typeY), width: 2, height: 1)

        return image
    }else{
        return nil
    }
}

func createMeasureImg(freq:String,nr:String,current:String) -> UIImage?{

    if var image = UIImage(named: "measure.png"){
        let w = image.size.width
        let h = image.size.height

        let nrX = w * form.share.widthPoint * 3
        let nrY = h * form.share.heightPoint * 3
        let freqX = w * form.share.widthPoint * 3
        let freqY = h * form.share.heightPoint * 4
        let currentX = w * form.share.widthPoint * 3
        let currentY = h * form.share.heightPoint * 5


        image = image.addText(drawText: nr,         atPoint: CGPoint(x: nrX, y: nrY), width: 2, height: 1)
        image = image.addText(drawText: freq,       atPoint: CGPoint(x: freqX, y: freqY), width: 2, height: 1)
        image = image.addText(drawText: current,    atPoint: CGPoint(x: currentX, y: currentY), width: 2, height: 1)

        return image
    }else{
        return nil
    }
}

func createResultImg(fl:String,nrRate:String,dl:String) -> UIImage?{

    if var image = UIImage(named: "result.png"){
        let w = image.size.width
        let h = image.size.height

        let flX = w * form.share.widthPoint * 3
        let flY = h * form.share.heightPoint * 3
        let nrRateX = w * form.share.widthPoint * 3
        let nrRateY = h * form.share.heightPoint * 4
        let dlX = w * form.share.widthPoint * 3
        let dlY = h * form.share.heightPoint * 5


        image = image.addText(drawText: fl,         atPoint: CGPoint(x: flX, y: flY), width: 2, height: 1)
        image = image.addText(drawText: nrRate,     atPoint: CGPoint(x: nrRateX, y: nrRateY), width: 2, height: 1)
        image = image.addText(drawText: dl,         atPoint: CGPoint(x: dlX, y: dlY), width: 2, height: 1)

        return image
    }else{
        return nil
    }
}
