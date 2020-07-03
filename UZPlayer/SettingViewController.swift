//
//  SettingViewController.swift
//  UZPlayerExample
//
//  Created by Nam Nguyen on 7/3/20.
//  Copyright © 2020 Nam Kennic. All rights reserved.
//

import UIKit

public class SettingViewController: UIViewController {
    private let withNavigationButton: Bool
    private var settingItems: [SettingItem]?
    private let text: String?
    private var tableView = UITableView()
    open weak var delegate: UZSettingViewDelegate?

    init(withNavigationButton: Bool, text: String? = nil, settingItems: [SettingItem]? = nil) {
        self.withNavigationButton = withNavigationButton
        self.text = text
        self.settingItems = settingItems
        super.init(nibName: nil, bundle: nil)
        self.title = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "setting_row")
//        let contentView = UIView.makeView(withTitle: text)
//        view.backgroundColor = tableView?.backgroundColor
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 46.0
        let contentHeight: CGFloat = 4.0 + 46.0 * CGFloat(self.settingItems?.count ?? 0 + 1)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: contentHeight),
        ])

        preferredContentSize.height = contentHeight
//
//        if withNavigationButton {
//            let button = UIButton(type: .system)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//            button.setTitle("Next", for: .normal)
//            button.setTitleColor(.white, for: .normal)
//            button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
//            view.addSubview(button)
//
//            NSLayoutConstraint.activate([
//                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                button.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
//            ])
//        }
    }
//    @objc private func handleButtonTap() {
//        let viewController = SettingViewController(withNavigationButton: false, contentHeight: contentHeight)
//        viewController.title = "Step 2"
//        navigationController?.pushViewController(viewController, animated: true)
//    }
}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
        
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingItems?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "setting_row", for: indexPath)
        if let settingItem = self.settingItems?[indexPath.row] {
            cell.textLabel?.text = settingItem.title ?? ""
            if settingItem.toggle {
                let toogle = UISwitch(frame: CGRect.zero)
                toogle.tag = settingItem.tag.rawValue
                toogle.isOn = settingItem.toggleOn
                toogle.addTarget(self, action: #selector(onToggleAction(_:)), for: .valueChanged)
                cell.accessoryView = toogle
            }
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        if let settingItem = self.settingItems?[indexPath.row] {
            if settingItem.toggle {
                let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
                let toggle = (currentCell.accessoryView as! UISwitch)
                toggle.isOn = !toggle.isOn
                self.delegate?.settingRow(sender: toggle)
                setNeedsFocusUpdate()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc open func onToggleAction(_ sender: UISwitch) {
        self.delegate?.settingRow(sender: sender)
    }
}

private extension UIView {
    static func makeView(withTitle title: String? = nil) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hue: 0.5, saturation: 0.3, brightness: 0.6, alpha: 1.0)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .white
        view.addSubview(label)

        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .white
        borderView.alpha = 0.4
        view.addSubview(borderView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 2),
            borderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }
}
