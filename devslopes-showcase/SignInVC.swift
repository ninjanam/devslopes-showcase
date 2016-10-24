//
//  ViewController.swift
//  devslopes-showcase
//
//  Created by Nam-Anh Vu on 20/10/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // user is already logged in, bypass login screen
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_ID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }

    @IBAction func facebookBtnTapped(sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (result:FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            if error != nil {
                print("Unable to authenticate with Facebook. error \(error)")
            } else if result?.isCancelled == true {
                print("User cancelled Facebook authenticaion")
            } else {
                //let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
              //  print("Successfully logged in with facebook. \(accessToken)")
                print("Successfully logged in with Facebook")
                
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                // logged in with Facebook, now talk to Firebase
                self.firebaseAuth(credential)
            }
            
        }
    }
    
    func firebaseAuth(credential: FIRAuthCredential) {
        FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) -> Void in
            if error != nil {
                print("Unable to authenticate with Firebase - \(error)")
            } else {
                print("Successfully authenticated with Firebase")
                //Save new Firebase account
                NSUserDefaults.standardUserDefaults().setValue(user?.uid, forKey: KEY_ID)
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
            }
        })
    }
}

