//
//  DetailViewController.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/7/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgMedia: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    
    @IBOutlet weak var viewBuyHD: UIView!
    @IBOutlet weak var viewBuy: UIView!
    @IBOutlet weak var viewRentHD: UIView!
    @IBOutlet weak var viewRent: UIView!
    
    @IBOutlet weak var lblHDPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblHDRentPrice: UILabel!
    @IBOutlet weak var lblRentPrice: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    var primaryKey: Int? {
        didSet {
            configureData()
        }
    }
    
    private var viewModel: ItunesMediaInfoViewModel? {
        didSet {
            configureView()
        }
    }
    
    // MARK: - View Controller Lifecycle
    // Used by our scene delegate to return an instance of this class from our storyboard.
    static func loadFromStoryboard() -> DetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if #available(iOS 13.0, *) {
            view.window?.windowScene?.userActivity = nil
        }
        
    }
    
    func configureData() {
        if let primaryKey = primaryKey {
            if let objectModel = RealmItunesMediaManager().getObject(with: primaryKey) {
                self.viewModel = ItunesMediaInfoViewModel(model: objectModel)
            }
        }
    }
   
    func configureView() {
        if let viewModel = viewModel,
            let imgMedia = imgMedia,
            let lblTitle = lblTitle,
            let lblYear = lblYear,
            let lblGenre = lblGenre,
            let lblDescription = lblDescription {
            
            imgMedia.sd_setImage(with: viewModel.imageUrl, placeholderImage: UIImage(named: "imagePlaceholder"))
            lblTitle.text = viewModel.name
            
            lblYear.text = viewModel.releaseDate
            lblGenre.text = viewModel.genre
            
            lblDescription.text = viewModel.description
            
            customizeSubviews()
        }
    }
    
    func customizeSubviews() {
        if let viewBuyHD = viewBuyHD,
            let viewBuy = viewBuy,
            let viewRentHD = viewRentHD,
            let viewRent = viewRent,
            let lblPrice = lblPrice,
            let lblHDPrice = lblHDPrice,
            let lblRentPrice = lblRentPrice,
            let lblHDRentPrice = lblHDRentPrice {
            
        viewBuyHD.makeRoundedCornerViews()
        viewBuy.makeRoundedCornerViews()
        viewRentHD.makeRoundedCornerViews()
        viewRent.makeRoundedCornerViews()
                
        viewBuyHD.isHidden = !(viewModel?.buyHDPrice != nil)
        viewBuy.isHidden = !(viewModel?.buyPrice != nil)
        viewRentHD.isHidden = !(viewModel?.rentHDPrice != nil)
        viewRent.isHidden = !(viewModel?.rentPrice != nil)
        
        lblPrice.text = viewModel?.buyPrice
        lblHDPrice.text = viewModel?.buyHDPrice
        lblRentPrice.text = viewModel?.rentPrice
        lblHDRentPrice.text = viewModel?.rentHDPrice
        }
    }
}

// MARK: - NSUserActivity Support

extension DetailViewController {
    
    static let restoreActivityKey = "RestoreActivity"
    static let activityPrimaryKey = "primaryKey"

    class var activityType: String {
        let activityType = ""

        // Load our activity type from our Info.plist.
        if let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] {
            if let activityArray = activityTypes as? [String] {
                return activityArray[0]
            }
        }

        return activityType
    }
    
    func applyUserActivityEntries(_ activity: NSUserActivity) {
        let itemPrimaryKey: [String:Int] = [DetailViewController.activityPrimaryKey: primaryKey!]
        activity.addUserInfoEntries(from: itemPrimaryKey)
    }

    // Used to construct an NSUserActivity instance for state restoration.
    var detailUserActivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: DetailViewController.activityType)
        userActivity.title = "Restore Item"
        applyUserActivityEntries(userActivity)
        return userActivity
    }
    
}

// MARK: - UIUserActivityRestoring

extension DetailViewController {
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        super.updateUserActivityState(activity)
        applyUserActivityEntries(activity)
    }

    override func restoreUserActivityState(_ activity: NSUserActivity) {
         super.restoreUserActivityState(activity)

        // Check if the activity is of our type.
        if activity.activityType == DetailViewController.activityType {
            // Get the user activity data.
            if let activityUserInfo = activity.userInfo {
                let primaryKeyObject = activityUserInfo[DetailViewController.activityPrimaryKey]
                self.primaryKey = primaryKeyObject as? Int
            }
        }
    }

}

// MARK: - State Restoration (UIStateRestoring)

extension DetailViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)

        let encodedActivity = NSUserActivityEncoder(detailUserActivity)
        coder.encode(encodedActivity, forKey: DetailViewController.restoreActivityKey)
    }
   
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        if coder.containsValue(forKey: DetailViewController.restoreActivityKey) {
            if let decodedActivity = coder.decodeObject(forKey: DetailViewController.restoreActivityKey) as? NSUserActivityEncoder {
                if let activityUserInfo = decodedActivity.userActivity.userInfo {
                    let objectPrimaryKey = activityUserInfo[DetailViewController.activityPrimaryKey]
                    self.primaryKey = objectPrimaryKey as? Int
                }
            }
        }
    }
}
