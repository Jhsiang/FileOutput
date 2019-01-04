//
//  InputTableViewCell.swift
//  FileOutput
//
//  Created by Jim Chuang on 2019/1/3.
//  Copyright © 2019 nhr. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textfield: UITextField!
    @IBOutlet var unitLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
