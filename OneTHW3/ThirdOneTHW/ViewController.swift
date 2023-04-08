//
//  ViewController.swift
//  ThirdOneTHW
//
//  Created by Artyom Prima on 04.04.2023.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let checkedImage = UIImage(systemName: "checkmark.circle.fill")
    private let uncheckedImage = UIImage(systemName: "circle")
    var isSelected: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
        view.backgroundColor = .white
        setConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        let imageView = UIImageView(image: UIImage(named: "ToDo"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width/2, height: 24) // set frame to half the width of the view
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        // Create and configure search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self // set the search results updater to the appropriate view controller
        
        let searchBarWidth = view.frame.width/2 // set the width of the search bar to half the width of the view
        let searchBarContainerView = UIView(frame: CGRect(x: 0, y: 0, width: searchBarWidth, height: 44))
        searchBarContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.frame = searchBarContainerView.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBarContainerView)
    }
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setConstraints() {
       
        view.addSubview(tableView)
        view.addSubview(addButton)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailingMargin).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-20)
            make.width.height.equalTo(60)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Handle search results here
    }
    
    private let viewForTask: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    private let addNewTask: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 14
        button.setTitle("Create Task", for: .normal)
        button.addTarget(self, action: #selector(addNewTaskTapped), for: .touchUpInside)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.text = "Create a Task"
        label.textAlignment = .left
        return label
    }()
    
    private var taskTextField: UITextField = {
        let textFieldTitle = UITextField()
        textFieldTitle.placeholder = " Enter your task"
        textFieldTitle.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textFieldTitle.returnKeyType = .done
        
        return textFieldTitle
    }()
    
    @objc private func addButtonTapped() {
        view.addSubview(viewForTask)
        viewForTask.addSubview(addNewTask)
        viewForTask.addSubview(label)
        viewForTask.addSubview(taskTextField)
        
        viewForTask.snp.makeConstraints { make in
            make.top.equalTo(view.frame.size.height/1.5)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(viewForTask.snp_topMargin).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        addNewTask.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(26)
            make.height.equalTo(50)
        }
        
        taskTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp_bottomMargin).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(106)
        }
    }
    
    @objc private func addNewTaskTapped() {
        guard let newTaskText = taskTextField.text else { return }
        
        let newTask = Data(text: newTaskText, completion: false)
        task.append(newTask)
        
        NetworkService.shared.postData(text: newTaskText, isCompleted: false) { error in
              if let error = error {
                  print("Error posting new task: \(error)")
              } else {
                  DispatchQueue.main.async {
                      self.tableView.reloadData()
                  }
              }
          }
        
        taskTextField.text = ""
        viewForTask.isHidden = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        task.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        74
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        var currentTask = task[indexPath.section]
        
        cell.settingTast(task: currentTask)
        cell.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        cell.completionTadded = { button in
            if currentTask.completion == true {
                button.setImage(self.uncheckedImage, for: .normal)
            } else {
                button.setImage(self.checkedImage, for: .normal)
            }
            
            NetworkService.shared.getDocumentID(name: currentTask.text) { documentID in
                guard let documentID = documentID else {
                    print("Document ID not found")
                    return
                }
                
                NetworkService.shared.updateData(documentID: documentID, isCompleted: button.isSelected) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        currentTask.completion = button.isSelected
                    }
                }
            }
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [self] _, _, _ in
            let name = task[indexPath.section].text
            NetworkService.shared.getDocumentID(name: name) { documentID in
                guard let documentID = documentID else {
                    print("Document ID not found")
                    return
                }
                
                NetworkService.shared.deleteData(documentID: documentID) { error in
                    if let error = error {
                        print("Error deleting document: \(error)")
                    } else {
                        task.remove(at: indexPath.section)
                        tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                    }
                }
            }
            
        }
        delete.backgroundColor = .clear
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}
