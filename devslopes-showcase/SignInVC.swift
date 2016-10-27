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

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
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
                print("Successfully logged in with Facebook")
                
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                // logged in with Facebook, now talk to Firebase
                self.firebaseAuth(credential)
            }
            
        }
    }
    
    // for use with other third-party logins like Twitter or Google
    func firebaseAuth(credential: FIRAuthCredential) {
        FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) -> Void in
            if error != nil {
                print("Unable to authenticate with Firebase - \(error)")
            } else {
                print("Successfully authenticated with Firebase")
                //Save new Firebase account
                if let user = user {
                    let userData = ["provider": credential.provider, "blah": "test"]
                    self.completeSignIn(user.uid, userData: userData)
                }
            }
        })
    }
    
    @IBAction func attemptLogin(sender: UIButton) {
        
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { (user, error) -> Void in
                
                if error != nil {
                    print(error)
                    if error!.code == STATUS_ACCOUNT_NONEXIST {
                        FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { (user, error) -> Void in
                            if error != nil {
                                print("Unable to authenticate new user with Firebase")
                                self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
                            } else {
                                print("New user created and authenticated in Firebase")
                                FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: nil)
                                if let user = user {
                                    let userData = ["provider": user.providerID]
                                    self.completeSignIn(user.uid, userData: userData)
                                }
                            }
                        })
                    } else if error!.code == STATUS_WRONG_PASSWORD {
                        self.showErrorAlert("Could not log in", msg: "Please check your username or password")
                    }
                } else {
                    print("Email user successfully authenticated into Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(user.uid, userData: userData)
                    }
                }
            })
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(id, userData: userData)
        NSUserDefaults.standardUserDefaults().setValue(id, forKey: KEY_ID)
        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}









