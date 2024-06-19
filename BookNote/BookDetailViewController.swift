//
//  BookDetailViewController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/19.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var bookmarkTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var bookImageView: UIImageView!
    
    weak var delegate: BookDetailViewControllerDelegate?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFields()
    }
    
    private func configureFields() {
        guard let book = book else { return }
        
        titleTextField.text = book.title
        authorTextField.text = book.author
        publisherTextField.text = book.publisher
        startDateTextField.text = book.startDate
        endDateTextField.text = book.endDate
        memoTextField.text = book.memo
        
        if let imageData = book.imageData {
            bookImageView.image = UIImage(data: imageData)
        } else {
            bookImageView.image = UIImage(named: "placeholder")
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard var editedBook = book else { return }
        
        editedBook.title = titleTextField.text ?? ""
        editedBook.author = authorTextField.text ?? ""
        editedBook.publisher = publisherTextField.text ?? ""
        editedBook.startDate = startDateTextField.text ?? ""
        editedBook.endDate = endDateTextField.text ?? ""
        editedBook.memo = memoTextField.text ?? ""
        
        if let selectedImage = bookImageView.image {
            editedBook.imageData = selectedImage.jpegData(compressionQuality: 0.8)
        }
        
        delegate?.didUpdateBook(editedBook)
        
        navigationController?.popViewController(animated: true)
    }
}
