//
//  BookListViewController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadBooks()
    }
    
    func loadBooks() {
        if let data = UserDefaults.standard.data(forKey: "books"),
           let savedBooks = try? JSONDecoder().decode([Book].self, from: data) {
            books = savedBooks
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        let book = books[indexPath.row]
        cell.configure(with: book)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            
            saveBooks(books)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func saveBooks(_ books: [Book]) {
        if let data = try? JSONEncoder().encode(books) {
            UserDefaults.standard.set(data, forKey: "books")
        }
    }
}
