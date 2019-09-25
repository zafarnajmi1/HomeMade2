//
//  APIBaseManager.swift
//  TailerOnline
//
//  Created by apple on 3/28/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import Alamofire


class BaseManager: NSObject {
    
    var sessionManager: SessionManager
    var basePath: String
    var rawHeader: HTTPHeaders
   
    
    override init() {
        
        sessionManager = Alamofire.SessionManager.default
        basePath = API.baseURL.dev
        rawHeader = ["Content-Type": "application/json"]

    }
    
    func authHeader() -> HTTPHeaders  {
        guard  let authId = AppSettings.shared.loggedInUser?.authorization  else {
           return ["Authorization": ""]
        }
        return ["Authorization": authId]
    }
    
    
    //1: API Sub Path  Constants
    struct BasePath {
        static let baseURL = BasePath.dev
        static let dev =  "https://www.projects.mytechnology.ae/homemade/\(myDefaultLanguage)/api/"
        static let staging = ""
        static let production = ""
    }
    struct auth {
        static let login = "login"
        static let register = "register"
        static let authEmailVerification = "auth/email-verification"
        static let authResendVerficationCode = "auth/resend-verification-code"
        static let forgotPassword = "forgot-password"
        static let resetPassword = "reset-password"
        static let authUpdateUserAddress = "auth/update/user-addresses"
        static let socialLogin = "social-login"
        static let socialLoginCheck = "social-login/check"
    }

    
    struct admin{
        
        struct Features{
            
            static let authFeaturesView =  "auth/features/view"
            static let authFeatureStore = "auth/feature/store"
            static let authFeatureEdit = "auth/feature/edit"
            static let authFeatureDelete = "auth/feature/delete"
            static let authFeatureUpdate = "auth/feature/update"
            
        }
        
        struct  Characteristics {
            static let authCharacteristicsView = "auth/characteristics/view"
            static let authCharacteristicStore = "auth/characteristic/store"
            static let authCharacteristicUpdate = "auth/characteristic/update"
            static let authCharacteristicEdit = "auth/characteristic/edit"
            static let authCharacteristicDelete = "auth/characteristic/delete"
        }
        
       
        
    }
    
    struct packages{
        
        static let authPackagesView = "auth/packages/view"
        static let authPackagesPurchase = "auth/purchase-package"
    }
    
    struct profile{
        
        static let authProfile = "auth/profile"
        static let authChangePassword = "auth/change-password"
        static let authUpdateProfile = "auth/update-profile"
        static let authUpdateStorePaypalCredentials = "auth/update-store/paypal-credentials"
        
    }
    
    struct quotations {
        
        static let authQuotationRequest = "auth/quotation/request"
        static let authQuotationListing = "auth/quotation/listing"
        static let authQuotationResponse = "auth/quotation/response"
        static let authQuotationDetail = "auth/quotation/detail"
        static let authQuotationResponseAccept = "auth/quotation/response/accept"
        static let authQuotationResponseReject = "auth/quotation/response/reject"
        static let authQuotationReceipts = "auth/quotation/receipts"
        static let authquotationResponseDeliver = "auth/quotation/response/deliver"
        
    }
    
    struct products {
        
        static let authProductStore = "auth/product/store"
        static let authProductUpdate = "auth/product/update"
        static let authProductEdit = "auth/product/edit"
        static let authProductDelete = "auth/product/delete"
        static let productSearch = "product/search"
        static let authProductDetail = "auth/product/detail"
        static let authProductreview = "auth/product/review"
        static let authPurchasePackage = "auth/purchase-package"
        static let authProductSearch = "product/search"
    }
    
    struct indexRoot {
        
        static let settings = "settings"
        static let sliders = "sliders"
        static let contactUs = "contact-us"
        static let categories  = "categories"
        static let featureCharacteristics = "features-characteristics"
    }
    
    struct store {
        
        static let storeDetail = "store-detail"
        static let stores = "stores"
    }
    
    struct cart {
        
        static let authCartAddProduct = "auth/cart/add-product"
        static let authCart = "auth/cart"
        static let authCartUpdate = "auth/cart/update"
        static let authCartProductRemove = "auth/cart/product/remove"
        
    }
    
    struct checkout {
        
        static let authUpdateUserAddresses = "auth/update/user-addresses"
        
    }

    
    struct orders {
        
        static let authPayment = "auth/payment"
        static let authShipProduct = "auth/ship/product"
        static let authOrderDetail = "auth/order/detail"
        static let authCompleteProduct  = "auth/complete/product"
        static let authOrdersShow  = "auth/orders/show"
        static let authCheckout = "auth/checkout"
        
    }
//    struct auth {
//        static let login = "login"
//        static let register = "register"
//        static let authEmailVerification = "auth/email-verification"
//        static let authResendVerficationCode = "auth/resend-verification-code"
//        static let forgotPassword = "forgot-password"
//        static let resetPassword = "reset-password"
//        static let socialLogin = "social-login"
//        static let socialLoginCheck = "social-login/check"
//    }
    
    struct setting {
        static let settings = "settings"
        static let contactus = "contact-us"
    }
    
    
    struct CategoryURLs {
        
    }

    
}
let GOOGLE_API_KEY =  "AIzaSyBnW1wbtDB6F5-mwXF_Y2uJ-m-_22ef-x8"
let GOOGLE_PLACES_API_KEY = "AIzaSyBnW1wbtDB6F5-mwXF_Y2uJ-m-_22ef-x8"



let dev =  "https://www.projects.mytechnology.ae/homemade/\(myDefaultLanguage)/api/"




let staging = ""
let production = ""
let baseURL = dev

let LOGIN = baseURL + "login"
let REGISTER = baseURL + "register"
let VERIFICATION_CODE = baseURL + "auth/email-verification"
let RESEND_VERIFICATION_CODE = baseURL + "auth/resend-verification-code"
let FORGOT_PASSWORD = baseURL + "forgot-password"
let RESET_PASSWORD = baseURL + "reset-password"
let UPDATE_USER_ADDRESS = baseURL + "auth/update/user-addresses"
let SOCIAL_LOGIN = baseURL + "social-login"
let SOCIAL_LOGIN_CHECK = baseURL + "social-login/check"

let storeDetail = baseURL + "store-detail"
let STORES_LIST = baseURL + "stores"
let STORES_LIST_MAP = baseURL + "store/nearby"
let STORES_DETAILS = baseURL + "auth/store-detail"
//let STORE_PRODUCTS = baseURL + "auth/product/search"
let STORE_REVIEWS = baseURL + "store/reviews"
let SUBMIT_REVIEWS = baseURL + "auth/submit/store-review"
let MY_STORE_REVIEWS = baseURL + "auth/store/reviews"

let SETTINGS = baseURL + "settings"
let SLIDERS = baseURL + "sliders"
let CONTACT_US = baseURL + "contact-us"
let CATEGORIES  = baseURL + "categories"
let FEATURE_CHARACTERISTICS = baseURL + "features-characteristics"


let GET_PROFILE = baseURL + "auth/profile"
let CHANGE_PASSWORD = baseURL + "auth/change-password"
let UPDATE_PROFILE = baseURL + "auth/update-profile"
let UPDATE_STORE_PAYPAL_CREDENTIALS = baseURL + "auth/update-store/paypal-credentials"
let UPDATE_PROFILE_SETTING = baseURL + "auth/update-profile-settings"

let FETCH_CATEGORIES = baseURL + "categories"
let SEARCH_ITEMS = baseURL + "auth/product/search"
let FILTER_STORES = baseURL + "stores/view"
let PRODUCT_DETAILS = baseURL + "auth/product/detail"
let FAVORITE_PRODUCT = baseURL + "auth/favorite-product"



let ADD_TO_CART = baseURL + "auth/cart/add-product"
let UPDATE_CART = baseURL + "auth/cart/update"
let REMOVE_FROM_CART = baseURL + "auth/cart/product/remove"
let GET_CART = baseURL + "auth/cart"
let GET_SETTINGS = baseURL + "settings"

//let UPDATE_USER_ADDRESS = baseURL + "auth/update/user-addresses"
//let CHECKOUT = baseURL + "auth/checkout"
let PAYMENT = baseURL + "auth/payment"
let ORDER_STATUS = baseURL + "auth/orders/stats"
let USER_ORDERS = baseURL + "auth/orders/show"
let STORE_ORDERS = baseURL + "auth/orders/stores"
let SHIP_PRODUCT = baseURL + "auth/ship/product"
let COMPLETE_PRODUCT = baseURL + "auth/complete/product"
let CANCEL_PRODUCT = baseURL + "auth/cancel/product"

let ORDER_DETAIL = baseURL + "auth/order/detail"
let ORDER_STORE_DETAIL = baseURL + "auth/orders/stores/detail"




let NOTIFICATIONS_UPDATED = "NOTIFICATIONS_UPDATED"


    

