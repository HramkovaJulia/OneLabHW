//
//  NetworkService.swift
//  ThirdOneTHW
//
//  Created by Artyom Prima on 05.04.2023.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

class NetworkService {
    
    let dataBase = Firestore.firestore()
    
    static let shared = NetworkService()
    
    func getData(completion: @escaping () -> Void) {
        dataBase.collection("tasks").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for doc in querySnapshot!.documents {
                    if let name = doc.data()["name"] as? String, let completion = doc.data()["completion"] as? Bool {
                        task.append(Data(text: name, completion: completion))
                    }
                }
                completion()
            }
        }
    }
    
    func deleteData(documentID: String, completion: @escaping (Error?) -> Void) {
        dataBase.collection("tasks").document(documentID).delete() { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }

    func postData(text: String, isCompleted: Bool, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = ["name": text, "completion": isCompleted]
        dataBase.collection("tasks").addDocument(data: data) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func getDocumentID(name: String, completion: @escaping (String?) -> Void) {
        dataBase.collection("tasks").whereField("name", isEqualTo: name).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
                return
            }
            
            guard let document = snapshot?.documents.first else {
                print("Document not found")
                completion(nil)
                return
            }
            
            let documentID = document.documentID
            completion(documentID)
        }
    }

    func updateData(documentID: String, isCompleted: Bool, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = ["completion": isCompleted]
        dataBase.collection("tasks").document(documentID).updateData(data) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}

