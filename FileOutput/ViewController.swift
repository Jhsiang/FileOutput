//
//  ViewController.swift
//  FileOutput
//
//  Created by Jim Chuang on 2018/12/20.
//  Copyright © 2018 nhr. All rights reserved.
//

import UIKit
import PDFGenerator
import PDFReader
import Social

class ViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet var myIV: UIImageView!
    @IBOutlet var myLabel: UILabel!
    
    @IBOutlet var shareBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        creatMyImgPDF()
        readPDF()
    }

    override func viewDidAppear(_ animated: Bool) {
        //A4 21*29
        myLabel.text = "40342"

//        creatMyImgPDF()
//        readPDF()

        //creatMyPDF()
        //readPDF()
        
    }

    @IBAction func shareBtnClick(_ sender: UIBarButtonItem) {
        let documentFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("sample1.pdf")
        let pdfData = NSData(contentsOf: documentFileURL)
        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)

        self.present(activityViewController, animated: true, completion: nil)


    }


    func readPDF(){
        //let documentFileURL = Bundle.main.url(forResource: "sample1", withExtension: "pdf")!
        //FileManager.default.temporaryDirectory.appendingPathComponent(name)

        let documentFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("sample1.pdf")
        print("path = ",documentFileURL)
        if let document = PDFDocument(url: documentFileURL){
            let readerController = PDFViewController.createNew(with: document)
            if let nav = navigationController{
                nav.pushViewController(readerController, animated: true)
            }else{
                self.present(readerController, animated: true, completion: nil)
            }
        }else{
            print("error 1")
        }

        if UIPrintInteractionController.canPrint(documentFileURL){
            print("yes")
        }else{
            print("no")
        }

    }

    func toPrintPDF(name:String) -> Bool{
        let guide_url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        if UIPrintInteractionController.canPrint(guide_url) {
            let printInfo = UIPrintInfo(dictionary: nil)
            printInfo.jobName = guide_url.lastPathComponent
            printInfo.outputType = .photo

            let printController = UIPrintInteractionController.shared
            printController.printInfo = printInfo
            printController.showsNumberOfCopies = false

            printController.printingItem = guide_url

            printController.present(animated: true, completionHandler: nil)
            return true
        }else{
            print("can't print")
            return false
        }
    }

    func creatMyImgPDF(){
        var image = UIImage(named: "image3.png")!

        let w = image.size.width
        let h = image.size.height

        let x1 = w * form.share.widthPoint * 3
        let x2 = w * form.share.widthPoint * 4
        let y1 = h * form.share.heightPoint * 8
        let y2 = h * form.share.heightPoint * 9
        let y3 = h * form.share.heightPoint * 10
        let y4 = h * form.share.heightPoint * 17

        image = image.addText(drawText: "Intel", atPoint: CGPoint(x: x1, y: y1), width: 2, height: 1)
        image = image.addText(drawText: "Skylake", atPoint: CGPoint(x: x1, y: y2), width: 2, height: 1)
        image = image.addText(drawText: "H161217-C08", atPoint: CGPoint(x: x1, y: y3), width: 2, height: 1)
        image = image.addText(drawText: "Jason", atPoint: CGPoint(x: x2, y: y4), width: 1, height: 1)

        generteMyImgPDF(imgArr: [image])
    }

    func creatMyPDF(){
        let v1 = UIView(frame: CGRect(origin: CGPoint(x: 500, y: 500), size: PDFPageSize.A4))
        let imageView = UIImageView(frame: v1.bounds)
        var image = UIImage(named: "image1.png")!
        image = image.addText(drawText: "Hello world", atPoint: CGPoint(x: 0, y: 0))
        image = image.addText(drawText: "40342", atPoint: CGPoint(x: 100, y: 200))
        imageView.image = image

        let labelW:CGFloat = 40
        let labelH:CGFloat = 40
        let label = UILabel(frame: CGRect(x: v1.bounds.width/2-labelW/2 , y: v1.bounds.height/2-labelH/2, width: labelW, height: labelH))
        label.text = "NO:A3028"
        label.adjustsFontSizeToFitWidth = true

        let space:CGFloat = 88
        let myTF = UITextField(frame: CGRect(x: label.bounds.minX, y: label.bounds.maxY+space, width: label.bounds.width, height: label.bounds.height))
        myTF.delegate = self


        v1.addSubview(imageView)
        v1.addSubview(label)
        v1.addSubview(myTF)

        self.view.addSubview(v1)

        //generateMyPDF(view: [self.view])

        generateMyPDF(view: [v1])
    }

    @objc func keyBoardWillShow(note:NSNotification){

    }



    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

    }

}

