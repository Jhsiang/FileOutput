//
//  SettingTableViewController.swift
//  FileOutput
//
//  Created by Jim Chuang on 2019/1/3.
//  Copyright © 2019 nhr. All rights reserved.
//

import UIKit
import PDFReader
import PDFGenerator

class SettingTableViewController: UITableViewController,UITextFieldDelegate {

    let H190103 = Report()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(H190103.myTotalArr[0])
        print(H190103.title.custom)
        print("--------------")

        H190103.myTotalArr[0] = "haha"
        print(H190103.myTotalArr[0])
        print(H190103.title.custom)
        print("--------------")

        H190103.title.custom = "gg"
        print(H190103.myTotalArr[0])
        print(H190103.title.custom)
        print("--------------")


        /*
        H190103.spec.centerFreq = 25.000000
        H190103.unit.fl = 10.55
        H190103.measure.frequency = 25.000625
        print(H190103.result.shiftFL!)

        H190103.unit.rr = 14.38
        H190103.measure.current = 2
        print(H190103.result.driveLevel!)

        H190103.measure.negativeResistance = 550
        H190103.spec.maxESR = 70
        print(H190103.result.nrRate!)
        */

    }

    override func viewDidAppear(_ animated: Bool) {


        //NotificationCenter.default.addObserver(self, selector: #selector(myTFDidBeginEditing(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(myTFDidEndEditing()), name: UITextField.textDidEndEditingNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(myTFShouldReturn(_:)), name: UITextField.return, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        //NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
    }
    
    @IBAction func createBtnClick(_ sender: UIBarButtonItem) {

        if H190103.iSFullCondition(){
            let t = H190103.title
            let s = H190103.spec
            let m = H190103.measure
            let r = H190103.result

            var imageArr = Array<UIImage>()

            if let titleImg = createTitleImg(custom: t.custom!, modelName: t.modelName!, projectNo: t.projectNo!, actor: t.actor!){
                imageArr.append(titleImg)
            }

            if let specImg = createSpecImg(cl: s.centerCL!.toStr(), freq: s.centerFreq!.toStr(), maxESR: s.maxESR!.toStr(), size: s.packageSize!, type: s.sealType!){
                imageArr.append(specImg)
            }

            if let measureImg = createMeasureImg(freq: m.frequency!.toStr(), nr: m.negativeResistance!.toStr(), current: m.current!.toStr()){
                imageArr.append(measureImg)
            }

            if let resultImg = createResultImg(fl: r.shiftFL!, nrRate: r.nrRate!, dl: r.driveLevel!){
                imageArr.append(resultImg)
            }

            if imageArr.count > 0{
                imageArrToPDF(arr: imageArr)
            }

            readPDF()
            
        }else{
            let alert = UIAlertController(title: "error", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
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


    func textFieldDidBeginEditing(_ textField: UITextField) {

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        H190103.myTotalArr[textField.tag] = textField.text
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        H190103.myTotalArr[textField.tag] = textField.text
        textField.endEditing(true)
        return true
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return H190103.arr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_input", for: indexPath) as! InputTableViewCell
        cell.titleLabel.text = H190103.arr[indexPath.row]
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        cell.unitLabel.text = ""
        cell.textfield.delegate = self
        cell.textfield.tag = indexPath.row

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
