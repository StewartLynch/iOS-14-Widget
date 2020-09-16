//
//  DetailViewController.swift
//  I Remember
//
//  Created by Stewart Lynch on 2020-09-13.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    enum IconString: String, CaseIterable {
        case other, contact, door, key, phone, car
    }
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var detail1: UITextField!
    @IBOutlet weak var detail2: UITextField!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var makePrimaryBtn: UIButton!
    @IBOutlet weak var iconSelection: UISegmentedControl!
    var updateItem: ((RememberItem) -> Void)?
    var newItem:((RememberItem) -> Void)?
    var deleteItem:((RememberItem) -> Void)?
    var switchPrimary:((RememberItem) -> Void)?
    var item:RememberItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showItem()
        setupNavBar()
        if let item = item {
            makePrimaryBtn.isHidden = item.isPrimary
        } else {
            makePrimaryBtn.isHidden = true
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func makePrimary(_ sender: Any) {
        item?.isPrimary.toggle()
        switchPrimary?(item!)
        self.navigationController?.popViewController(animated: true)

    }

    func setupNavBar() {
        if let _ = newItem  {
        let rightBarButtonItem = UIBarButtonItem.init(title: "Add", style: .done, target: self, action: #selector(addItem))
        let leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(dismissModal))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            let rightBarButtonItem = UIBarButtonItem.init(title: "Delete", style: .done, target: self, action: #selector(removeItem))
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
        
    }
    
    func showItem() {
        guard let item = item else { return }
        itemTitle.text = item.title
        detail1.text = item.detail1
        detail2.text = item.detail2
        icon.image = UIImage(named: item.icon)!
        for (index,icon) in IconString.allCases.enumerated() {
            if item.icon == icon.rawValue {
                iconSelection.selectedSegmentIndex = index
            }
        }
    }
   
    @objc func removeItem() {
        self.navigationController?.popViewController(animated: true)
        deleteItem?(item!)
    }
    
    @objc func addItem() {
        let new = RememberItem(title: itemTitle.text ?? "", icon: IconString.allCases[iconSelection.selectedSegmentIndex].rawValue , detail1: detail1.text ?? "", detail2: detail2.text ?? "")
        newItem?(new)
        dismissModal()
    }
    

    
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        for (index,icon) in IconString.allCases.enumerated() {
            if sender.selectedSegmentIndex == index {
                self.icon.image = UIImage(named: icon.rawValue)
                self.item?.icon = icon.rawValue
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let updateItem = updateItem, var item = item {
            item.title = itemTitle.text ?? ""
            item.detail1 = detail1.text ?? ""
            item.detail2 = detail2.text ?? ""
            updateItem(item)
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
