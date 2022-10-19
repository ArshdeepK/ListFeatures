//
//  AddNewGarmentViewController.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import UIKit

class AddNewGarmentViewController: UIViewController {
    // MARK: - Variables
    
    var viewModel: AddNewGarmentViewModel!
    var addGarmentSuccessClosure: (()->())?

    // MARK: - Outlets

    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initialise View Model
        initViewModel()
        
        // Activate Textfield
        productNameTextField.becomeFirstResponder()
     
        // Add Textfield Editing Changed Target
        productNameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        // Set enabled button state
        changeSaveButtonEnabledState()
    }
    
    // MARK: - Actions

    @IBAction func saveBarButtonItemTapped(_ sender: Any) {
        viewModel.saveProduct(name: productNameTextField.text!.trimmed)
        dismiss(animated: true) {
            self.addGarmentSuccessClosure?()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddNewGarmentViewController {
    
    // MARK: - Initialise View Model
    
    func initViewModel() {
        viewModel = AddNewGarmentViewModel(databaseAccess: .init())
        
        // View Model Closures
        showAlertClosure()
    }
    
    // MARK: - View Model Closures
    
    func showAlertClosure() {
        // Show Alert
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                if let message = self.viewModel.alertMessage {
                    self.alert(error: message)
                }
            }
        }
    }
    
    // MARK: - Button Enabled State
    
    func changeSaveButtonEnabledState() {
        saveBarButtonItem.isEnabled = (productNameTextField.text ?? "").count > 0
    }
    
    // MARK: - Textfield Editing Changed
    
    @objc func textFieldEditingChanged (_ textField:UITextField) {
        changeSaveButtonEnabledState()
    }
}
