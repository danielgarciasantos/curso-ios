//
//  SalvarViewController.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit
import SwiftMessages

class SalvarViewController: UIViewController {
    
    @IBOutlet weak var titulo: UITextField!
    
    @IBOutlet weak var salvar: UIButton!
    @IBOutlet weak var dataExpiracao: UIButton!
    @IBOutlet weak var completo: UISwitch!
    @IBOutlet weak var descricao: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        salvar?.contentMode = .scaleAspectFit
        salvar?.clipsToBounds = true
        salvar!.layer.cornerRadius = 11.2
        
        dataExpiracao?.contentMode = .scaleAspectFit
        dataExpiracao?.clipsToBounds = true
        dataExpiracao!.layer.cornerRadius = 11.2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func btnDataExpiracao(_ sender: UIButton) {
    }
    
    @IBAction func btnSalvar(_ sender: UIButton) {
        self.showLoanding()
        let task = Result()
        task.expiration_date = "2017-12-10"
        task.descriptionn = self.descricao.text
        task.title = self.titulo.text
        task.is_complete = self.completo.isOn
    
        AppService().salvarTask(task: task, Success: { reponse in
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
                view.configureContent(title: "Task", body: "Nova Task salva com sucesso!")
                view.button?.isHidden = true
                view.configureTheme(Theme.success)
                view.configureDropShadow()
                return view
            }
        }, onError: { error in
            
        }, always: {
            self.hideLoading()
        })
    }
    
}
