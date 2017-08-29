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
                print("Successfully Authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        })
    }

    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("NOTE: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("NOTE: Unable to authenticate with Firebase using email")
                        } else {
                            print("NOTE: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }

    //Passed in parameters for function since we can no longer reach the object
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        Dataservice.ds.createFirebaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("JESS: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)

        
    }





}

