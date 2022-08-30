//
//  JSONEncodeDecodeViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/29.
//

import UIKit

class JSONEncodeDecodeViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: JSONEncodeDecodeViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        test1()
        test2()
        
    }
    
    private func test1() {
        
        do {
            
            var student = Student(id: "127182781278", name: "小明", grade: 1)
            
            let jsonData = try JSONEncoder().encode(student)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            ILog.debug(tag: #file, content: jsonString)
            
            student = try JSONDecoder().decode(Student.self, from: jsonData)
            ILog.debug(tag: #file, content: student)
            
            
        }
        catch {
            ILog.debug(tag: #file, content: error.localizedDescription)
        }
    }
    
    private func test2() {
        
        var classObject = Class(classNumber: "123", students: [
            Student(id: "127182781277", name: "小明", grade: 1),
            Student(id: "127182781278", name: "小红", grade: 1),
            Student(id: "127182781279", name: "小刚", grade: 1)
        ])
        
        do {
            let jsonData = try JSONEncoder().encode(classObject)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            ILog.debug(tag: #file, content: jsonString)
            
            
            classObject = try JSONDecoder().decode(Class.self, from: jsonData)
            ILog.debug(tag: #file, content: classObject)
            
            
        }
        catch {
            ILog.debug(tag: #file, content: error.localizedDescription)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private struct Student: Codable {
    var id: String
    var name: String
    var grade: Int
}

private struct Class: Codable {
    
    var classNumber: String
    var students: [Student]
}
