//
//  Book.swift
//  BookNote
//
//  Created by mac030 on 2024/06/19.
//

import Foundation

struct Book: Codable {
    var title: String
    var author: String
    var publisher: String
    var startDate: String?
    var endDate: String?
    var memo: String
    var imageData: Data?
}

protocol BookDetailViewControllerDelegate: AnyObject {
    func didUpdateBook(_ book: Book)
}

extension UserDefaults {
    private enum Keys {
        static let books = "books"
    }
    
    func saveBooks(_ books: [Book]) {
        if let data = try? JSONEncoder().encode(books) {
            set(data, forKey: Keys.books)
        }
    }
    
    func loadBooks() -> [Book] {
        if let data = data(forKey: Keys.books),
           let books = try? JSONDecoder().decode([Book].self, from: data) {
            return books
        }
        return []
    }
}
