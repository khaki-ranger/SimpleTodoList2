//
//  ViewController.swift
//  SimpleTodoList2
//
//  Created by 寺島 洋平 on 2019/08/02.
//  Copyright © 2019年 YoheiTerashima. All rights reserved.
//

import UIKit

// UITableViewDataSource、UITableViewDelegateのプロトコルを実装する旨の宣言を行う
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // ToDoを格納した配列
    var todoList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 保存しているToDoの読み込み処理
        let userDefaults = UserDefaults.standard
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
            todoList.append(contentsOf: storedTodoList)
        }
    }
    
    // +ボタンをタップした時に呼ばれる処理
    @IBAction func tapAddButton(_ sender: Any) {
        // アラートダイアログを生成
        let alertController = UIAlertController(title: "ToDo追加", message: "ToDoを入力してください", preferredStyle: UIAlertControllerStyle.alert)
        
        // テキストエリアを追加
        alertController.addTextField(configurationHandler: nil)
        // OKボタンを追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            // OKボタンがタップされたときの処理
            if let textField = alertController.textFields?.first {
                // ToDoの配列に入力値を挿入。先頭に挿入する
                self.todoList.insert(textField.text!, at: 0)
                // テーブルに行が追加されたことをテーブルに通知
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.right)
                // ToDoの保存処理
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.todoList, forKey: "todoList")
                userDefaults.synchronize()
            }
        }
        // OKボタンがタップされたときの処理
        alertController.addAction(okAction)
        // CANCELLボタンがタップされたときの処理
        let canncelButton = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.cancel, handler: nil)
        // CANCELLボタンを追加
        alertController.addAction(canncelButton)
        // アラートダイアログを表示
        present(alertController, animated: true, completion: nil)
    }
    
    // テーブルの行数を返却する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Todoの配列の長さを返却
        return todoList.count
    }
    
    // テーブルの行ごとのセルを返却する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Storyboardで指定したtodoCell識別子を利用して再利用可能なセルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        // 行番号にあったToDoのタイトルを取得
        let todoTitle = todoList[indexPath.row]
        // セルのラベルにToDoのタイトルをセット
        cell.textLabel?.text = todoTitle
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

