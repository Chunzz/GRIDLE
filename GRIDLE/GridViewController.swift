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
            
            //Looks for single or multiple taps.
//             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

//            view.addGestureRecognizer(tap)
        
        }

        // required method for keyboard delegate protocol
        func keyWasTapped(character: String) {
            textField.deleteBackward()
            textField.insertText(character)
        }
    
    
    func cancelKeyboard(){
        textField.deleteBackward()
        dismissKeyboard()
    }
    
    func confirmKeyboard(){
        dismissKeyboard()

    }
    
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
