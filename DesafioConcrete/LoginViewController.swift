
//
//  LoginViewController.swift
//  DesafioConcrete
//
//  Created by Matheus Henrique on 06/09/2018.
//  Copyright © 2018 Concrete.Matheus Henrique. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldEmail: UITextField!    
    @IBOutlet weak var textFieldSenha: UITextField!
    
    //MARK: Ciclo da view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            //Verifica o último usuário conectado. Extremamente útil ficar aqui para evitar que o usuário faça login novamente ou o objeto Auth fique em estágio intermediário. Isso conserta o erro de update de dados depois de fechar o aplicativo e abrir novamente
        }//_ = Auth.auth().addStateDidChangeListener
    }//viewWillAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Verifica se possui usuário ativo
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "segueEntraUsuario", sender: self)
        }//if Auth.auth().currentUser
    }////func viewDidAppear
    
    //MARK: Cadastro Firebase
    @IBAction func criarConta(_ sender: Any) {
        let cadastrarAlert = UIAlertController(title: "Novo Usuário", message: "Insira um e-mail e senha", preferredStyle: .alert)
        
        var emailAlert = UITextField.init()
        var senhaAlert = UITextField.init()
        var confirmacaoAlert = UITextField.init()
        
        cadastrarAlert.addTextField { emailCadastro in
            emailCadastro.placeholder = "E-mail"
            emailCadastro.keyboardType = .emailAddress
            emailAlert = emailCadastro
            //emailCadastro.text = self.emailFornecidoIncorreto
        }//cadastrarAlert.addTextField
        
        cadastrarAlert.addTextField { senhaCadastro in
            senhaCadastro.placeholder = "Senha"
            senhaCadastro.keyboardType = .default
            senhaCadastro.isSecureTextEntry = true
            senhaAlert = senhaCadastro
        }//cadastrarAlert.addTextField
        
        cadastrarAlert.addTextField { confirmacaoSenha in
            confirmacaoSenha.placeholder = "Confirmar Senha"
            confirmacaoSenha.keyboardType = .default
            confirmacaoSenha.isSecureTextEntry = true
            confirmacaoAlert = confirmacaoSenha
        }//cadastrarAlert.addTextField
        
        let emailAcao = UIAlertAction(title: "Cadastrar", style: .default) { _ in
            self.registraFirebase(email: emailAlert.text!, senha: senhaAlert.text!, confirmacao: confirmacaoAlert.text!)
        }//let emailAcao = UIAlertAction
        
        cadastrarAlert.addAction(emailAcao)
        cadastrarAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(cadastrarAlert, animated: true, completion: nil)
    }//func criarConta
    
    func registraFirebase(email: String, senha: String, confirmacao: String){
        
        if(senha == confirmacao){ //As senhas correspondem
            
            Auth.auth().createUser(withEmail: email, password: senha) { (user, error) in
                
                if error == nil{ //Sucesso no cadastro
                    
                    let sucessoAlert = UIAlertController(title: "\(email) cadastrado com sucesso", message: "Você pode fazer login agora!", preferredStyle: .alert)
                    let okAcao = UIAlertAction(title: "Ok", style: .default) { action in}
                    sucessoAlert.addAction(okAcao)
                    self.present(sucessoAlert, animated: true, completion: nil)
                    
                }//if erro
                else{//Erro manipulado pelo Firebase
                    self.manipulaErrosAuth(erro: error)
                }//else erro
            }//Auth.auth().createUser(withEmail: email!, password: senha!)
        }//if senha == confirmacao
            
        else{
            let senhaDiferenteAlert = UIAlertController(title: "Senha", message: "As senhas não correspondem. Tente novamente", preferredStyle: .alert)
            let okAcao = UIAlertAction(title: "Fechar", style: .default) { action in}
            senhaDiferenteAlert.addAction(okAcao)
            self.present(senhaDiferenteAlert, animated: true, completion: nil)
        }//Else senha
    }//func registraFirebase()
    
    @IBAction func entrar(_ sender: Any) {
        let email = textFieldEmail.text
        let senha = textFieldSenha.text
        
        Auth.auth().signIn(withEmail: email!, password: senha!) { (user, error) in
            
            if error == nil{
                self.performSegue(withIdentifier: "segueEntraUsuario", sender: self)
            }else{
                let erroUsuarioAlert = UIAlertController(title: "Usuário ou senha incorretos", message: "Verifique seus dados e a conexão com a internet", preferredStyle: .alert)
                let fecharAcao = UIAlertAction(title: "Fechar", style: .default) { action in}
                erroUsuarioAlert.addAction(fecharAcao)
                self.present(erroUsuarioAlert, animated: true, completion: nil)
            }//else
        }//Auth.auth().signIn(withEmail)
    }//func entrar
    
    @IBAction func esqueciSenha(_ sender: Any) {
        let esqueciSenhaAlert = UIAlertController(title: "Redefinir Senha", message: "Insira seu e-mail cadastrado", preferredStyle: .alert)
        
        var emailAlert = UITextField.init()
        
        esqueciSenhaAlert.addTextField { emailTextFieldAlert in
            emailTextFieldAlert.placeholder = "E-mail cadastrado"
            emailTextFieldAlert.keyboardType = .emailAddress
            emailAlert = emailTextFieldAlert
        }//esqueciSenhaAlert.addTextField
        
        let emailAcao = UIAlertAction(title: "Enviar", style: .default) { _ in
            
            Auth.auth().sendPasswordReset(withEmail: emailAlert.text!) { (error) in
                
                if error == nil {
                    let sucessoAlert = UIAlertController(title: "Recuperação de senha", message: "E-mail de recuperação enviado com sucesso!", preferredStyle: .alert)
                    let certoAcao = UIAlertAction(title: "Ok", style: .default) { action in}
                    sucessoAlert.addAction(certoAcao)
                    self.present(sucessoAlert, animated: true, completion: nil)
                }else{
                    let falhaRecuperacaoAlert = UIAlertController(title: "Usuário não cadastrado", message: "Verifique o e-mail informado e sua conexão com a internet", preferredStyle: .alert)
                    let okAcao = UIAlertAction(title: "Ok", style: .default) { action in}
                    falhaRecuperacaoAlert.addAction(okAcao)
                    self.present(falhaRecuperacaoAlert, animated: true, completion: nil)
                }//else
            }//Auth.auth().sendPasswordReset(withEmail:
            
        }//let emailAcao = UIAlertAction
        
        esqueciSenhaAlert.addAction(emailAcao)
        esqueciSenhaAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(esqueciSenhaAlert, animated: true, completion: nil)
    }//func esqueciSenha
    
    func manipulaErrosAuth(erro:Error!){
        
        var tituloErro = ""
        var subtituloErro = ""
        
        if let errCode = AuthErrorCode(rawValue: erro!._code) {
            switch errCode {
            case .emailAlreadyInUse:
                tituloErro = "E-mail duplicado"
                subtituloErro = "Este e-mail já está sendo utilizado"
            case .networkError:
                tituloErro = "Falha de conexão"
                subtituloErro = "Verifique sua conexão com a internet e tente novamente"
            case .invalidEmail:
                tituloErro = "E-mail inválido"
                subtituloErro = "Por favor, verifique o e-mail inserido"
            case .requiresRecentLogin:
                tituloErro = "Entre novamente"
                subtituloErro = "Para efetuar este procedimento, você deve ter feito login recentemente"
            case .missingEmail:
                tituloErro = "E-mail não inserido"
                subtituloErro = "Por favor, verifique o e-mail inserido"
            case .weakPassword:
                tituloErro = "Senha fraca"
                subtituloErro = "Por favor, insira uma senha com 6 dígitos ou mais"
            default:
                print("Erro na criação de novo usuário: \(String(describing: erro))")
            }//switch errCode
        }//if let errCode = AuthErrorCode(rawValue: error!._code)
        
        let erroCadastroAlert = UIAlertController(title: tituloErro, message: subtituloErro, preferredStyle: .alert)
        
        let fecharAcao = UIAlertAction(title: "Fechar", style: .default) { action in}
        erroCadastroAlert.addAction(fecharAcao)
        
        self.present(erroCadastroAlert, animated: true, completion: nil)
    }//func manipulaErrosAuth()
    
    //MARK: Delegate Text Fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }//touchesBegan
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }//textFieldShouldReturn
    
}//Fim da classe
