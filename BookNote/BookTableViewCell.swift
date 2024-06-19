//
//  BookTableViewCell.swift
//  BookNote
//
//  Created by mac030 on 2024/06/19.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    func configure(with book: Book) {
           titleLabel.text = book.title
           authorLabel.text = "\(book.author)"
           publisherLabel.text = "\(book.publisher)"
           
           var datesText = ""
           if let startDate = book.startDate {
               datesText += "\(startDate) "
           }
           startDateLabel.text = datesText
        
        if let endDate = book.endDate {
                    endDateLabel.text = "\(endDate)"
                } else {
                    endDateLabel.text = "읽기 중"
                }
           
           if let imageData = book.imageData {
               bookImageView.image = UIImage(data: imageData)
           } else {
               bookImageView.image = UIImage(named: "placeholder")
           }
       }
   }
