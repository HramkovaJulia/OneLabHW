//
//  ContactsViewController.swift
//  OneTSecond
//
//  Created by Artyom Prima on 02.04.2023.
//

import UIKit

class ContactsViewController: UIViewController {

    lazy var groupedContacts: [String: [InfoContact]] = [:]
    var sectionTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setConstarints()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let sortedContacts = contactMembers.sorted { $0.name < $1.name }
                
        groupedContacts = sortedContacts.reduce(into: [String: [InfoContact]]()) { result, contact in
            let firstLetter = String(contact.name.first ?? "-")
            result[firstLetter, default: []].append(contact)
        }
                
        sectionTitles = groupedContacts.keys.sorted()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Создаем SearchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск контактов"
        navigationItem.searchController = searchController
        
        // Настройка отображения поискового бара
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        // Настройка Navigation Bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    @objc func addTapped() {
        let contactVC = NewContactViewController()
        contactVC.didCreateNewContact = { [weak self] newContact in
            contactMembers.append(newContact)
            let sortedContacts = contactMembers.sorted { $0.name < $1.name } 
            self?.groupedContacts = sortedContacts.reduce(into: [String: [InfoContact]]()) { result, contact in
                let firstLetter = String(contact.name.first ?? "-")
                result[firstLetter, default: []].append(contact)
            }
            self?.sectionTitles = self?.groupedContacts.keys.sorted() ?? []

        }
        navigationController?.pushViewController(contactVC, animated: true)
    }
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        return tableView
    }()
    
    func setConstarints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {[self] _, _, _ in
            print("delete button tapped")
            let contact = contactMembers[indexPath.row]
            let firstLetter = String(contact.name.first ?? "-")
            if var contacts = self.groupedContacts[firstLetter], let index = contacts.firstIndex(of: contact) {
                contacts.remove(at: index)
                if contacts.isEmpty {
                    self.groupedContacts.removeValue(forKey: firstLetter)
                    sectionTitles = groupedContacts.keys.sorted()
                } else {
                    self.groupedContacts[firstLetter] = contacts
                }
            }
            contactMembers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delete.backgroundColor = .red
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }

    func numberOfSections(in tableView: UITableView) -> Int {
          return sectionTitles.count
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let sectionTitle = sectionTitles[section]
          return groupedContacts[sectionTitle]!.count
      }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = sectionTitles[section]
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 18)
           label.textColor = .black
           label.text = sectionTitle
           return label.text
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionTitle = sectionTitles[indexPath.section]
        let contactsInSection = groupedContacts[sectionTitle] ?? []
        let contact = contactsInSection[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        cell.configContact(contact: contact)
        return cell
    }
}

extension ContactsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            // Если поисковый запрос пуст, то отображаем все контакты без фильтрации
            groupedContacts = contactMembers.reduce(into: [String: [InfoContact]]()) { result, contact in
                let firstLetter = String(contact.name.first ?? "-")
                result[firstLetter, default: []].append(contact)
            }
            sectionTitles = groupedContacts.keys.sorted()
            tableView.reloadData()
            return
        }
        
        let filteredContacts = contactMembers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
              
              // Группировка контактов по первой букве имени
              groupedContacts = filteredContacts.reduce(into: [String: [InfoContact]]()) { result, contact in
                  let firstLetter = String(contact.name.first ?? "-")
                  result[firstLetter, default: []].append(contact)
              }
              sectionTitles = groupedContacts.keys.sorted()
              tableView.reloadData()
          }
    }

