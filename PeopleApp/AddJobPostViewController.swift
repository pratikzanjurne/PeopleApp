
import UIKit

class AddJobPostViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var layer:CAGradientLayer?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialiseView()
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func initialiseView(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        let frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height , width: self.view.bounds.width, height: self.navigationController!.navigationBar.bounds.height)
        let colors = [UIColor(hexString: "#ED5E27").cgColor, UIColor(hexString: "#F54160").cgColor]
        let startPoint = CGPoint(x: 0.0, y: 0.5)
        let endPoint = CGPoint(x: 1.0, y: 0.5)
        UIHelper.shared.setGradientLayer(frame: frame, startPoint: startPoint, endPoint: endPoint, colors: colors) { (layer) in
            self.layer = layer
            self.view.layer.addSublayer(self.layer!)

        }
        self.view.backgroundColor = UIColor.black
        self.view.layoutIfNeeded()

    }
    
    @objc func onChangeOrientation(){
        self.view.layoutSublayers(of: self.view.layer)
    }
    override func viewDidLayoutSubviews() {

    }
}

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

