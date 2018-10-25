
import UIKit
import UserNotifications
import Popover

class JobPostCollectionViewController: UIViewController {
    @IBOutlet var addJobPostBtn: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var extendedView: UIView!
    var optionBtn:UIBarButtonItem!
    var layer:CAGradientLayer?
    var jobPosts = [HiringJobPostDataModel]()
    var isFetchingPosts = false
    var popover:Popover!
    var aView:UIView!
    var popoverStartpoint:CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        let cell = UINib(nibName: "JobPostCollectionViewCell", bundle: nil)
        let loadingCell = UINib(nibName: "LoadingCollectionViewCell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "JobPostCollectionViewCell")
        self.collectionView.register(loadingCell, forCellWithReuseIdentifier: "LoadingCollectionViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialiseView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initialiseView(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height)
        let colors = [UIColor(hexString: "#ED5E27").cgColor, UIColor(hexString: "#F54160").cgColor]
        let startPoint = CGPoint(x: 0.0, y: 0.5)
        let endPoint = CGPoint(x: 1.0, y: 0.5)
        UIHelper.shared.setGradientLayer(frame: frame, startPoint: startPoint, endPoint: endPoint, colors: colors) { (layer) in
            self.layer = layer
            self.view.layer.addSublayer(layer)
        }
        let extendedFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.extendedView.frame.height)
        UIHelper.shared.setGradientLayer(frame: extendedFrame, startPoint: startPoint, endPoint: endPoint, colors: colors) { (layer) in
            self.extendedView.layer.addSublayer(layer)
        }
        self.view.backgroundColor = UIColor.white
        self.optionBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "vertical_options"), style: .plain, target: self, action: #selector(onOptionBtnPressed))
        self.navigationItem.rightBarButtonItems = [self.optionBtn]

        self.popover = Popover()
        DBManager.init().requestAPIToGet(url: Constants.First ,parameters: nil, headers: Constants.headers) { (result) in
            self.jobPosts = result as! [HiringJobPostDataModel]
            self.collectionView.reloadData()
            Constants.prev = self.jobPosts[0].prev
            Constants.next = self.jobPosts[0].next
            Constants.totalJobCount = self.jobPosts[0].totalJobCount
        }
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .orange
        refreshControl.addTarget(self, action: #selector(onRefrechView), for: .valueChanged)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.refreshControl = refreshControl
        self.popoverStartpoint = CGPoint(x: self.view.frame.width - 33, y: (self.navigationController?.navigationBar.frame.height)!)
        self.aView = UIView(frame: CGRect(x: self.view.frame.width - (self.view.frame.width/3), y: (self.navigationController?.navigationBar.frame.height)!, width: self.view.frame.width/3, height: 150))
        UIHelper.shared.setCornerRadius(self.addJobPostBtn, radius: self.addJobPostBtn.frame.width/2)
        self.addJobPostBtn.addTarget(self, action: #selector(onAddJobPostBtnPressed), for: .touchUpInside)
    }
    @objc func onChangeOrientation(){
            self.initialiseView()
    }
    @objc func onRefrechView(){
        DBManager.init().requestAPIToGet(url: Constants.First ,parameters: nil, headers: Constants.headers) { (result) in
            self.jobPosts = result as! [HiringJobPostDataModel]
            self.collectionView.reloadData()
            Constants.prev = self.jobPosts[0].prev
            Constants.next = self.jobPosts[0].next
            Constants.totalJobCount = self.jobPosts[0].totalJobCount
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    @objc func onOptionBtnPressed(){
        popover.show(aView, point: popoverStartpoint)
    }
    
    @objc func onAddJobPostBtnPressed(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddJobPostViewController") as! AddJobPostViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
