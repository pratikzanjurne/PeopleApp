import Foundation
import UIKit
import TextFieldEffects

class LoginPage:UIView{
    @IBOutlet var containerView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var loginBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialiseView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialiseView()
    }
    
    func initialiseView(){
        Bundle.main.loadNibNamed("LoginPage", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        UIHelper.shared.setShadow(self.containerView, radius: 5.0, opacity: 0.5, color: .darkGray)
        UIHelper.shared.setCornerRadius(self.containerView, radius: 10.0)
    }
}
