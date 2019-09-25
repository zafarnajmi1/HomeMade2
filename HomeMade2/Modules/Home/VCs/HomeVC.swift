//
//  HomeVC.swift
//  HomeMade2
//
//  Created by Apple on 12/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlacePicker
import MapKit

class HomeVC: BaseVC {

    
    //MARK: Properties
    @IBOutlet weak var clv_Stores: UICollectionView!
    
    @IBOutlet weak var txt_location: UITextField!
    @IBOutlet weak var txt_keyword: UITextField!
    @IBOutlet weak var btn_rightTop: UIButton!
    @IBOutlet weak var btn_rightBottom: UIButton!
    @IBOutlet weak var btn_nearFarToggle: UIButton!
    @IBOutlet weak var gmv_map: GMSMapView!
    @IBOutlet weak var uv_bottom: HomeBottomView!
    @IBOutlet weak var uv_nearFarTray: UIView!
    var mapParams = StoreMapRequestParams()
    var mapLocation : CLLocationCoordinate2D?
    var listCoordinates : CLLocationCoordinate2D?
    var isShowingMap : Bool = true
    var currentLocation : Bool = false
    
    var isCurrentLocation : Bool {
        set {
            currentLocation = newValue
            uv_bottom.isCurrentLocation = newValue
        }
        get{
            return currentLocation
        }
    }
    var mapStores : [ListStore] = []
    
    
    var listParams = StoreListRequestParams()
    var listStores : [ListStore] = []
    //MARK: For dummy data

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //MARK: for txt field Enter Location
//        clv_Stores.register(UINib(nibName: "StoresCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "StoresCollectionViewCell")
    }
    override func setupView() {
        
        addNotificationButton()
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotificaitonCount), name: NSNotification.Name(rawValue: NOTIFICATIONS_UPDATED), object: nil)
        addCartButton()
        clv_Stores.register(ListStoreCell.nib, forCellWithReuseIdentifier: ListStoreCell.className)
        clv_Stores.refreshControl = refreshControl
        setupCollectionLayout()
        txt_location.addleftRightPading()
        txt_keyword.addleftRightPading(left: 30, right: 80)
        txt_keyword.attributedPlaceholder = NSAttributedString(string:"Enter Keyword".localized,
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        navigationItem.title = "HOMEMADE".localized
        gmv_map.delegate = self
        gmv_map.isMyLocationEnabled = true
        gmv_map.animate(toZoom: 14.0)
        clv_Stores.isHidden = true
        fetchMapStores()
    }
    func setupCollectionLayout(){
        let itemWidth: CGFloat  = ((AppSettings.screenWidth-30)/2)-1
        let itemHeight = itemWidth + 60
        let layout = clv_Stores.collectionViewLayout as! UICollectionViewFlowLayout
        
        //        let screenWidth = UIScreen.main.bounds.size.width
        //        let screenHeight = UIScreen.main.bounds.size.height
        //        let itemWidth = AppSettings.screenWidth
        //        let itemHeight = itemWidth * (934/1080)
//        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        clv_Stores.collectionViewLayout = layout
    }

    override func pullToRefreshView() {
        listParams.skip = 0
        if LocationManager.shared.isLocation{
            listParams.location = [LocationManager.longitude, LocationManager.latitude]
//            listParams.longitude = LocationManager.longitude
        }
        fetchListStore()
    }
    @IBAction func onClick_filter(_ sender: Any){
        let vc = FilterVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        vc.rootVC = .HomeScren
        vc.homeFilter.keyword = txt_keyword.text
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onClick_search(_ sender: Any){
        let vc = ProductListingVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        let params = SearchProductsRequest()
        params.keyword = txt_keyword.text
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onClick_rightTop(_ sender: Any){
        if !isShowingMap {
            btn_rightTop.setImage(UIImage(named: "map_current_loc"), for: .normal)
            clv_Stores.isHidden = true
            removeEmptyView()
        }
        else{
            if let location = gmv_map.myLocation{
                isCurrentLocation = true
                uv_bottom.isCurrentLocation = isCurrentLocation
                mapParams.latitude = location.coordinate.latitude
                mapParams.longitude = location.coordinate.longitude
                fetchMapStores()
                animateToLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                CommonManager().fetchAddress(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] (response, error) in
                    if let error = error{
                        self?.showError(body: error)
                    }
                    else if let result = response?.results{
                        if !result.isEmpty
                        {
                            let address = result[0]
                            self?.txt_location.text = address.formatted_address
                        }
                    }
                }
            }
        }
        isShowingMap = !isShowingMap
    }
    @IBAction func onClick_rightBottom(_ sender: Any){
        isShowingMap = false
        btn_rightTop.setImage(UIImage(named: "mappin"), for: .normal)
        clv_Stores.isHidden = false
        listParams.skip = 0
        if LocationManager.shared.isLocation{
            listParams.location = [LocationManager.longitude, LocationManager.latitude]
        }
        fetchListStore()
    }
    @IBAction func onClick_nearFarToggle(_ sender: Any){
        
        uv_nearFarTray.isHidden = !uv_nearFarTray.isHidden

    }
    func fetchListStore(){
//        listParams.pagination = "2"
        isRequestSent = true
        HomeManager().getStoresList(params: listParams) { [weak self] (response, error) in
            
            if self?.checkResponse(response: response, error: error) ?? false{
                
                self?.isLoadMore = ((response?.data?.count)! > 0)
                if self?.listParams.skip == 0{
                    self?.listStores = response?.data ?? []
                }
                else{
                    self?.listStores += response?.data ?? []
                }
                
                
                if self?.listStores.isEmpty ?? false{
                    self?.addEmptyView(frame: (self?.clv_Stores.frame)!)
                }
                else{
                    self?.removeEmptyView()
                }
                self?.clv_Stores.reloadData()
            }
        }

    }
    func fetchMapStores(){
        startAnimating()
        HomeManager().getMapStoresList(params: mapParams) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                
                self?.mapStores = response?.data ?? []
                self?.loadPinsOnMap()
                self?.uv_bottom.stores = self?.mapStores ?? []
                self?.uv_bottom.delegate = self
            }
        }
    }
    @IBAction func onClick_nearToFar(_ sender: Any){
        uv_nearFarTray.isHidden = true
        mapParams.isNear = true
        btn_nearFarToggle.setImage(UIImage(named: "map_near_to_far"), for: .normal)
        fetchMapStores()
    }
    @IBAction func onClick_farToNear(_ sender: Any){
        uv_nearFarTray.isHidden = true
        mapParams.isNear = false
        btn_nearFarToggle.setImage(UIImage(named: "map_far_to_near"), for: .normal)
        fetchMapStores()
        
    }
    func loadPinsOnMap(){
        gmv_map.clear()
        for (index,store) in mapStores.enumerated(){
            
            guard let location =  store.location
                else{
                    return
            }
            let position = CLLocationCoordinate2D(latitude: location[1], longitude: location[0])
            let pin = GMSMarker(position: position)
            let view = UIImageView(image: UIImage(named: (index == 0 ? "map_pin_yellow": "map_pin_blue")))
            view.tag = index
            pin.iconView = view
            pin.map = gmv_map
            store.marker = pin
        }
        if !mapStores.isEmpty && !isCurrentLocation{
            zoomMapAtLocation(object: mapStores[0])
        }
        
    }
    func zoomMapAtLocation(object : ListStore){
        guard let location = object.location
        else{
           return
        }
        animateToLocation(latitude: location[1], longitude: location[0])
    }
    func animateToLocation(latitude : Double, longitude : Double){
        let camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: gmv_map.camera.zoom)
        gmv_map.animate(to: camera)
    }
}
extension HomeVC : HomeBottomViewDelegate{
    func itemScrolled(lastIndex : Int, index: Int) {
        let lastImageView = mapStores[lastIndex].marker?.iconView as! UIImageView
        lastImageView.image = UIImage(named: "map_pin_blue")
        let store = mapStores[index]
        zoomMapAtLocation(object: store)
        let currentImageView = store.marker?.iconView as! UIImageView
        currentImageView.image = UIImage(named: "map_pin_yellow")
    }
    
    
}
extension HomeVC: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("You tapped at marker : \(marker.iconView?.tag ?? -1)")
        let lastIndex = uv_bottom.currentIndex
//        let imageView =
        
        
        let imageView = mapStores[lastIndex].marker?.iconView as! UIImageView
        imageView.image = UIImage(named: "map_pin_blue")
        
        
        let imageView2 = marker.iconView as! UIImageView
        imageView2.image = UIImage(named: "map_pin_yellow")

        if let index = marker.iconView?.tag{
            uv_bottom.scroll(to: index)
        }
        
        
        return true
    }

}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listStores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListStoreCell.className, for: indexPath) as! ListStoreCell
        if indexPath.row == (listStores.count - 1) && isRequestSent == false && isLoadMore {
            loadMore()
        }
        let object = listStores[indexPath.row]
        cell.loadCell(object: object)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let store = listStores[indexPath.row]
        let vc : StoreDetailVC = StoreDetailVC.viewController()
        vc.storeID = store._id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    func loadMore(){
        listParams.skip = listStores.count
        fetchListStore()
    }
    

}


extension HomeVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
        return false
    }
}


extension HomeVC: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
      //  self.location = place.coordinate
        
        
        //formate address
        if place.formattedAddress != nil {
            self.txt_location.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinates: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            mapParams.latitude = place.coordinate.latitude
            mapParams.longitude = place.coordinate.longitude
            isCurrentLocation = false
            fetchMapStores()
            self.txt_location.text = "Unkown Address, \(coordinate)"
        }
        
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        nvMessage.showError(body: "didFailAutocompleteWithError" )
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
