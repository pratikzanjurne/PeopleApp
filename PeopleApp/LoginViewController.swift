import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginPopUpView: LoginPage!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    func initialiseView(){
        UIHelper.shared.setCornerRadius(loginPopUpView, radius: 5)
        UIHelper.shared.setShadow(loginPopUpView, radius: 10.0, opacity: 0.5, color: UIColor.gray)
        self.loginPopUpView.loginBtn.addTarget(self, action: #selector(onLoginPressed), for: UIControlEvents.touchUpInside)
    }
    
    @objc func onLoginPressed(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JobPostCollectionViewController") as! JobPostCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
