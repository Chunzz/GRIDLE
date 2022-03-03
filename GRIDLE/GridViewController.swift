//
//  GridViewController.swift
//  GRIDLE
//
//  Created by Chun Long Fong on 3/3/22.
//

import UIKit

class GridViewController: UIViewController, KeyboardDelegate {

    override func viewDidLoad() {
            super.viewDidLoad()

            // initialize custom keyboard
            let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
            keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped

            // replace system keyboard with custom keyboard
            textField.inputView = keyboardView
        }

        // required method for keyboard delegate protocol
        func keyWasTapped(character: String) {
            textField.insertText(character)
        }

    @IBOutlet weak var textField: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
