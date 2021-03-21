//
//  ViewController.swift
//  AdvancedTableView
//
//  Created by Nikita Popov on 21.03.2021.
//

extension TableVC: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = ImageController()
        if let indexPath = tableView.indexPathForRow(at: location) {
            let section = sectionsArray[indexPath.section]
            let sellData = section.data[indexPath.row]
            let image = sellData.image
            vc.imageView.image = image
        }
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(UINavigationController(rootViewController: viewControllerToCommit), animated: true)
    }
     
}


import UIKit

class TableVC: UITableViewController {
    
    private let cellIdentifier = "someID"
    
    private var sectionsArray = [
        SectionData(open: true, data: [CellData(title: "Bob Shmob", image: UIImage(named: "0")!)]),
        SectionData(open: true, data: [CellData(title: "Bob Shmob", image: UIImage(named: "1")!),
                                       CellData(title: "Bob Shmob", image: UIImage(named: "0")!)]),
        SectionData(open: true, data: [CellData(title: "Bill Shmill", image: UIImage(named: "2")!)])
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CardCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        view.backgroundColor = UIColor.init(red: 228/255, green: 230/255, blue: 234/255, alpha: 1)
        navigationItem.title = "Spots"
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
    }
    
    // Sections and rows
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionsArray[section].open == true{
            return sectionsArray[section].data.count
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CardCell
        let section = sectionsArray[indexPath.section]
        cell.cellData = section.data[indexPath.row]
        cell.animate()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }
    
    // HEADER
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.tag = section
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)
        return button
    }
    
    @objc private func openSection(button: UIButton) {
        let section = button.tag
        
        var indexPathes = [IndexPath]()
        for row in sectionsArray[section].data.indices {
            let indexPathToDelete = IndexPath(row: row, section: section)
            indexPathes.append(indexPathToDelete)
        }
        
        let isOpen = sectionsArray[section].open
        sectionsArray[section].open = !isOpen
        
        button.setTitle(isOpen ? "Close" : "Open", for: .normal)
        
        if isOpen {
            tableView.deleteRows(at: indexPathes, with: .fade)
        } else {
            tableView.insertRows(at: indexPathes, with: .fade)
        }
    }
    
    
}

