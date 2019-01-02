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



