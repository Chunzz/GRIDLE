//
//  GridViewController.swift
//  GRIDLE
//
//  Created by Chun Long Fong on 3/3/22.
//

import UIKit

class GridViewController: UIViewController, KeyboardDelegate {
    var timer : Timer?
    @IBOutlet weak var timerLabel: UILabel!
    var counter = 0
    @IBAction func doneAction(_ sender: Any) {
        animateOut(desiredView: popupView)
        animateOut(desiredView: blurView)
        self.navigationController?.popViewController(animated: true)
        timer?.invalidate()
        timer = nil
    }
    @IBOutlet var popupView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var gridView: UIView!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if isMovingFromParent{
            timer?.invalidate()
            timer = nil
        }
    }
    @objc func processTimer() {
        counter += 1
        print("This is a second ", counter)
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let formattedString = formatter.string(from: TimeInterval(counter))!
        print(formattedString)
        
        timerLabel.text = "Timer: " + formattedString

    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(processTimer), userInfo: nil, repeats: true)

            // initialize custom keyboard
            let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
            keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped

            // replace system keyboard with custom keyboard
            textField.inputView = keyboardView
        blurView.bounds = self.view.bounds
        
        popupView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height*0.4)
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
        let solutionOne = textField.text
        if solutionOne != "2" {
            textField.deleteBackward()

//            let anim = CAKeyframeAnimation( keyPath:"transform" );
//            anim.values = [
//                NSValue( caTransform3D:CATransform3DMakeTranslation(-5, 0, 0 ) ),
//                NSValue( caTransform3D:CATransform3DMakeTranslation( 5, 0, 0 ) )
//            ]
//            anim.autoreverses = true
//            anim.repeatCount = 2
//            anim.duration = 7/100
//
//            gridView.layer.add( anim, forKey:nil )
            
            
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: gridView.center.x - 10, y: gridView.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: gridView.center.x + 10, y: gridView.center.y))
//            let animationColor = CABasicAnimation(keyPath: "backgroundColor")
//            animationColor.fromValue = UIColor.red
//            animationColor.toValue = UIColor.blue
            
            
            UIView.animate(withDuration: 0.5) {
                self.gridView.layer.backgroundColor = UIColor.red.cgColor
                self.gridView.layer.backgroundColor = UIColor.white.cgColor
            }
            
            gridView.layer.add(animation, forKey: "position")
//            gridView.layer.add(animation, forKey: "backgroundColor")

        } else {
            animateIn(desiredView: blurView)
            animateIn(desiredView: popupView)
        }
        print(solutionOne)
    }
    
    func animateIn(desiredView: UIView){
        let backgroundView = self.view!
        backgroundView.addSubview(desiredView)
        
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y:1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y:1.0)
            desiredView.alpha = 1
        })
    }
    
    func animateOut(desiredView: UIView){
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y:1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
        
        
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
