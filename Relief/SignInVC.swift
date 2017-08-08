//
//  ViewController.swift
//  Relief
//
//  Created by New on 6/5/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "goToSearch", sender: nil)
            print("NOTE: User ID Found In Keychain. Signing In")
    }
    }

        @IBAction func facebookBtnTapped(_ sender: Any) {

            let facebookLogin = FBSDKLoginManager()

            facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
                if error != nil {
                    print("NOTE: Unable to FB Authenticate")

                } else if result?.isCancelled == true {
                    print("NOTE: User Cancelled Authentication")
                } else {
                    print("NOTE: User has been successfully Authenticated")
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)

                    //Created second but, called in here
                    self.firebaseAuth(credential)
                }
            }
        }

    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in

            if error != nil {
                print("Note Unable to signin with Firebase -\(String(describing: error))")
            } else {

                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }

    //Passed in parameters for function since we can no longer reach the object
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("NOTE: Data Saved to Keychain \(keychainResult)")
        performSegue(withIdentifier: "goToSearch", sender: nil)

        
    }





}

