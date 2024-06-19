//
//  BookRegisterViewController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

class BookRegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var bookmarkTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var bookImageView: UIImageView!
    
    var selectedImage: UIImage?
    let imagePickerController = UIImagePickerController()
    let alertController = UIAlertController(title: "이미지 선택", message: "이미지를 선택할 방법을 고르세요", preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        enrollAlertEvent()
        addGestureRecognizer()
        
        // 이미지뷰의 콘텐츠 모드를 설정합니다.
        bookImageView.contentMode = .scaleAspectFit
    }
    
    func enrollAlertEvent() {
        let photoLibraryAlertAction = UIAlertAction(title: "사진 앨범", style: .default) { (action) in
            self.openAlbum()
        }
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(photoLibraryAlertAction)
        alertController.addAction(cameraAlertAction)
        alertController.addAction(cancelAlertAction)
    }
    
    func openAlbum() {
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePickerController.sourceType = .camera
            present(self.imagePickerController, animated: true, completion: nil)
        } else {
            print("Camera's not available.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                // Resize the image to fit within 200 points height, maintaining aspect ratio
                let resizedImage = resizeImage(image: image, targetHeight: 200.0)
                
                // Set the resized image to the image view
                bookImageView.image = resizedImage
                
                // Store the selected image
                selectedImage = resizedImage
            }
            dismiss(animated: true, completion: nil)
        }
        
        func resizeImage(image: UIImage, targetHeight: CGFloat) -> UIImage {
            let size = image.size
            let targetWidth = size.width * (targetHeight / size.height)
            let newSize = CGSize(width: targetWidth, height: targetHeight)
            
            let renderer = UIGraphicsImageRenderer(size: newSize)
            let scaledImage = renderer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: newSize))
            }
            
            return scaledImage
        }
    
    func addGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedUIImageView(_:)))
        self.bookImageView.addGestureRecognizer(tapGestureRecognizer)
        self.bookImageView.isUserInteractionEnabled = true
    }
    
    @objc func tappedUIImageView(_ gesture: UITapGestureRecognizer) {
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let title = titleTextField.text ?? ""
        let author = authorTextField.text ?? ""
        let publisher = publisherTextField.text ?? ""
        let startDate = startDateTextField.text ?? ""
        let endDate = endDateTextField.text ?? ""
        let memo = memoTextField.text ?? ""
        
        var imageData: Data?
        if let selectedImage = selectedImage {
            imageData = selectedImage.jpegData(compressionQuality: 0.8)
        }
        
        let newBook = Book(title: title, author: author, publisher: publisher, startDate: startDate, endDate: endDate, memo: memo, imageData: imageData)
        
        var books = loadBooks()
        books.append(newBook)
        saveBooks(books)
        
        titleTextField.text = ""
            authorTextField.text = ""
            publisherTextField.text = ""
            startDateTextField.text = ""
            endDateTextField.text = ""
            memoTextField.text = ""
            bookImageView.image = UIImage(named: "placeholder")
        
        showAlert(message: "책이 성공적으로 등록되었습니다.") {
            let bookListVC = BookListViewController()
                    self.navigationController?.pushViewController(bookListVC, animated: true)
        }
    }
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func loadBooks() -> [Book] {
        if let data = UserDefaults.standard.data(forKey: "books"),
           let savedBooks = try? JSONDecoder().decode([Book].self, from: data) {
            return savedBooks
        }
        return []
    }
    
    func saveBooks(_ books: [Book]) {
        if let data = try? JSONEncoder().encode(books) {
            UserDefaults.standard.set(data, forKey: "books")
        }
    }
}
