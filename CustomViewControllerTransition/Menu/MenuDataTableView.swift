//
//  MenuDataTableView.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/28.
//

import UIKit

protocol MenuDataTableViewProtocol: UITableViewDelegate, UITableViewDataSource {
    var selectedCell: MenuCell? { get }
}

final class MenuDataTableView: NSObject, MenuDataTableViewProtocol {
    weak var presenter: MenuPresenterProtocol?
    var selectedCell: MenuCell?
    private let tableData: [MenuData] = [
        MenuData(title: "Ocean", description: "This is Ocean", image: UIImage(named: "A")),
        MenuData(title: "Mountain", description: "This is Mountain", image: UIImage(named: "B")),
        MenuData(title: "Sky", description: "This is Sky", image: UIImage(named: "C")),
        MenuData(title: "Sea Turtle", description: "This is Sea Turtle", image: UIImage(named: "D")),
        MenuData(title: "Beach", description: "This is Beach", image: UIImage(named: "E"))
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableData[indexPath.row]
        let cellVM = MenuCellViewModel(data: data)
        let cell: MenuCell = tableView.dequeueReusable(for: indexPath)
        cellVM.config(cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath) as? MenuCell else { return }
        selectedCell = cell
        presenter?.didSelect(data: tableData[indexPath.row])
    }
}
