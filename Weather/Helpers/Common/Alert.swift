//
//  Alert.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 11.01.2024.
//

import UIKit
import Combine

 struct Alert {
    // MARK: - Types
     typealias Publisher = PassthroughSubject<Alert, Never>
    
     struct TextField {
         let configurationHandler: ((UITextField) -> Void)?
    }
    
     struct Action {
         let title: String
         var style: UIAlertAction.Style
         var color: UIColor
         var handler: VoidBlock?
         init(
            title: String,
            style: UIAlertAction.Style = .default,
            color: UIColor = .black,
            handler: VoidBlock? = nil
        ) {
            self.title = title
            self.style = style
            self.color = color
            self.handler = handler
        }
    }
    
     let title: String?
     let message: String?
     var style: UIAlertController.Style
     var actions: [Action]
     var textfields: [TextField]
        
     init(
        title: String?,
        message: String?,
        style: UIAlertController.Style = .alert,
        actions: [Action] = [.confirm],
        textfields: [TextField] = []
    ) {
        self.title = title
        self.message = message
        self.style = style
        self.actions = actions
        self.textfields = textfields
    }
    
     func makeAlert(onDissmiss: VoidBlock? = nil) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
                
        actions.forEach { action in
            let alertAction = UIAlertAction(
                title: action.title,
                style: action.style,
                handler: { _ in
                    action.handler?()
                    onDissmiss?()
                }
            )
            
            alert.addAction(alertAction)
        }
        
        return textfields.reduce(into: alert) { alert, textfield in
            alert.addTextField(configurationHandler: textfield.configurationHandler)
        }
    }
}

 extension Alert {
    static func `default`(message: String) -> Alert {
        Alert(
           title: nil,
           message: message
       )
    }
    
    static var somethingWentWrong = Alert(
        title: "Ui.Alert.Titles.somethingWentWrong".localized,
        message: "Ui.Alert.Messages.tryAgainLater".localized
    )

}

 extension Alert.Action {
    static let confirm = Alert.Action(
        title: "Ui.Universal.Title.understand".localized
    )
    
    static func confirm(_ handler: @escaping VoidBlock) -> Alert.Action {
        Alert.Action(
            title: "Ui.Universal.Title.understand".localized,
            handler: handler
        )
    }
    
    static let cancel = Alert.Action(
        title: "Ui.Universal.Title.cancel".localized,
        style: .cancel,
        color: .mainText
    )
    
    static func cancel(handler: @escaping VoidBlock) -> Alert.Action {
        Alert.Action(
            title: "Ui.Universal.Title.cancel".localized,
            style: .cancel,
            color: .secondText,
            handler: handler
        )
    }
}
