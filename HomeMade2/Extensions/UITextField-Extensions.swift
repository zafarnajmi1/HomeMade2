import UIKit
import Foundation

private var maxLengths = [UITextField: Int]()
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged
            )
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text,
            prospectiveText.count > maxLength else {return}
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
}

extension UITextField {
    @IBInspectable var padding: Int{
        get { return 0 }  // maybe use associated objects, you can't add properties in extensions
        set {
            addleftRightPading(left : newValue, right: newValue)
        }
    }
    func addleftPading(_ value : Int = 22){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: value, height: 40))
        view.isUserInteractionEnabled = false
        leftView = view
        leftViewMode = .always
        
    }
    func addRightPading(_ value : Int = 22){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: value, height: 40))
        view.isUserInteractionEnabled = false
        rightView = view
        rightViewMode = .always
    }
    func addleftRightPading(left : Int = 22, right: Int = 22){
        addleftPading(left)
        addRightPading(right)
    }
}
