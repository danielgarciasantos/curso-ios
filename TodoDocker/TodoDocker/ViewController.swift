//
//  ViewController.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 06/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftMessages

class ViewController: UIViewController {
    
    @IBOutlet weak var ok: UIButton!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var login: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        ok?.clipsToBounds = true
        ok!.layer.cornerRadius = 11.2
        ok?.contentMode = .scaleAspectFit
        
        senha?.contentMode = .scaleAspectFit
        senha?.clipsToBounds = true
        senha!.layer.cornerRadius = 11.2
        
        login?.contentMode = .scaleAspectFit
        login?.clipsToBounds = true
        login!.layer.cornerRadius = 11.2
        
        self.login.text = "danielgarsantos@gmail.com"
        self.senha.text = "015730da"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func buttonOk(_ sender: UIButton) {

        if self.login.text == "" {
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
                view.configureContent(title: "Login", body: "Informe o login.")
                view.button?.isHidden = true
                view.configureTheme(Theme.warning)
                view.configureDropShadow()
                return view
            }
            return
        }
        if self.senha.text == "" {
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
                view.configureContent(title: "Senha", body: "Informe a senha.")
                view.button?.isHidden = true
                view.configureTheme(Theme.warning)
                view.configureDropShadow()
                return view
            }
            return
        }
        guard self.senha.text != "" && self.login.text != "" else { return }
        self.singIn(login: self.login.text!, senha: self.senha.text!)
    }
    
    
    func singIn(login: String, senha: String) {
        self.showLoanding()
        AppService().postLogin(username: login, password: senha, Success: { response in
            if response?.httpStatusCode == 200{
                loginModel = (response?.body)!
                self.prepareSegue()
            }
        }, onError: { error in
            if error?.httpResponseCode == 401{
                SwiftMessages.show {
                    let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
                    view.configureContent(title: "Erro login", body: "Usuário ou senha incorretos!")
                    view.button?.isHidden = true
                    view.configureTheme(Theme.error)
                    view.configureDropShadow()
                    return view
                }
            }
        }, always: {
            self.hideLoading()
        })
    }
    
    func prepareSegue() {
        self.performSegue(withIdentifier: "loginSucess", sender: self)
    }
}

