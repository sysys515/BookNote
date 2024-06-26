//
//  CalendarViewController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

class CalendarViewController: UIViewController {
    
    lazy var dateView: UICalendarView = {
        var view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        return view
    }()
    
    var selectedDate: DateComponents? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        applyConstraints()
        setCalendar()
        reloadDateView(date: Date())
    }
    
    fileprivate func applyConstraints() {
        view.addSubview(dateView)
        
        let dateViewConstraints = [
            dateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ]
        NSLayoutConstraint.activate(dateViewConstraints)
    }
    
    fileprivate func setCalendar() {
            dateView.delegate = self
            
            let dateSelection = UICalendarSelectionSingleDate(delegate: self)
            dateView.selectionBehavior = dateSelection
        }
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
            let calendar = Calendar.current
            dateView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let selectedDate = selectedDate, selectedDate == dateComponents {
            return .customView {
                let label = UILabel()
                label.text = "📖"
                label.textAlignment = .center
                return label
            }
        }
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }
}
