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

    }

    override func viewDidAppear(_ animated: Bool) {
        //A4 21*29
        myLabel.text = "40342"
        creatMyPDF()
        readPDF()
        
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

    func creatMyPDF(){
        let v1 = UIView(frame: CGRect(origin: CGPoint.zero, size: PDFPageSize.A4))
        let imageView = UIImageView(frame: v1.bounds)
        let image = UIImage(named: "image1.png")
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

