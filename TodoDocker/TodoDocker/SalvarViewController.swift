//
//  SalvarViewController.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit
import SwiftMessages
import DatePickerDialog


class SalvarViewController: UIViewController  {
    
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var salvar: UIButton!
    @IBOutlet weak var dataExpiracao: UIButton!
    @IBOutlet weak var completo: UISwitch!
    @IBOutlet weak var descricao: UITextView!
    
    var taskSelected: Result!
    var editTaks = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        salvar?.contentMode = .scaleAspectFit
        salvar?.clipsToBounds = true
        salvar!.layer.cornerRadius = 11.2
        
        dataExpiracao?.contentMode = .scaleAspectFit
        dataExpiracao?.clipsToBounds = true
        dataExpiracao!.layer.cornerRadius = 11.2
        
        
        descricao?.contentMode = .scaleAspectFit
        descricao?.clipsToBounds = true
        descricao!.layer.cornerRadius = 11.2
        
        if editTaks {
            self.titulo.text = taskSelected.title
            self.descricao.text = taskSelected.descriptionn
            self.completo.setOn(taskSelected.is_complete!, animated: true)
        } else {
            taskSelected = Result()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnDataExpiracao(_ sender: UIButton) {
        var date: Date!
        if editTaks {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            date = dateFormatter.date(from: taskSelected.expiration_date!)
        } else {
            date = Date()
        }
        let datePicker = DatePickerDialog(textColor: .darkGray,
                                          buttonColor: .blue,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Data de expiração !",
                        doneButtonTitle: "Ok",
                        cancelButtonTitle: "Cancelar",
                        defaultDate: date,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                self.taskSelected.expiration_date = formatter.string(from: dt)
                            }
        }
    }
    
    @IBAction func btnSalvar(_ sender: UIButton) {
        taskSelected.descriptionn = self.descricao.text
        taskSelected.title = self.titulo.text
        taskSelected.is_complete = self.completo.isOn
        
        if editTaks {
            editarTask()
        } else {
            salvarTask()
        }
    }
    
    func editarTask() {
        self.showLoanding()
        AppService().editarTask(task: taskSelected, Success: { reponse in
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
                view.configureContent(title: "Update Task", body: "Task atualizada com sucesso!")
                view.button?.isHidden = true
                view.configureTheme(Theme.success)
                view.configureDropShadow()
                return view
            }
            self.navigationController?.popViewController(animated: true)
        }, onError: { error in
            
        }, always: {
            self.hideLoading()
        })
    }
    
    func salvarTask() {
        self.showLoanding()
        AppService().salvarTask(task: taskSelected, Success: { reponse in
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
                view.configureContent(title: "New Task", body: "Task salva com sucesso!")
                view.button?.isHidden = true
                view.configureTheme(Theme.success)
                view.configureDropShadow()
                return view
            }
            self.navigationController?.popViewController(animated: true)
        }, onError: { error in
            
        }, always: {
            self.hideLoading()
        })
    }
    
}
