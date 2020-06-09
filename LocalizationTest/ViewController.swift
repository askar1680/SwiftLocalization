//
//  ViewController.swift
//  LocalizationTest
//
//  Created by Аскар on 6/9/20.
//  Copyright © 2020 askar.ulubayev. All rights reserved.
//

import UIKit
import Localize_Swift

class ViewController: UITableViewController {
    
    private let strings: [String] = [
        AppLocalization.cancel.rawValue,
        AppLocalization.thankYou.rawValue,
        AppLocalization.welcome.rawValue
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeViews()
    }
    
    @objc private func changeLanguageTapped() {
        if Localize.currentLanguage() == LanguageType.en.rawValue {
            Localize.setCurrentLanguage(LanguageType.ru.rawValue)
        } else if Localize.currentLanguage() == LanguageType.ru.rawValue {
            Localize.setCurrentLanguage(LanguageType.kz.rawValue)
        } else {
            Localize.setCurrentLanguage(LanguageType.en.rawValue)
        }
    }
    
    @objc private func languageChanged() {
        tableView.reloadData()
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = strings[indexPath.row].localized()
        return cell
    }
}

extension ViewController {
    private func stylizeViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(changeLanguageTapped)
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageChanged),
            name: NSNotification.Name(LCLLanguageChangeNotification),
            object: nil
        )
    }
}

extension String {
    func localize() -> String {
        return self.localized()
    }
}
