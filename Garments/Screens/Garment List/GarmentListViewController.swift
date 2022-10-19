//
//  GarmentListViewController.swift
//  Garments
//
//  Created by Arshdeep on 2022-08-25.
//

import UIKit

class GarmentListViewController: UIViewController {
    
    // MARK: - Constants
    
    let reuseIdentifier = "basicStyle"
    
    // MARK: - Variables
   
    var viewModel: GarmentListViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Initialize view model
        initViewModel()
    }
    
    // MARK: - Actions
  
    @IBAction func segmentValueChanged(_ sender: Any) {
        if let segmentedControl = sender as? UISegmentedControl {
            // Refresh the products according to selected segment.
            viewModel.sortProductsBy(segment: segmentedControl.selectedSegmentIndex)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationViewController:AddNewGarmentViewController = (segue.destination as? UINavigationController)?.viewControllers.first as? AddNewGarmentViewController {
            
            // Refresh the products according to selected segment after a product is added successfully.
            destinationViewController.addGarmentSuccessClosure = { [weak self] () in
                guard let self = self else { return }
                self.viewModel.sortProductsBy(segment: self.segmentedControl.selectedSegmentIndex)
            }
        }
    }
}

extension GarmentListViewController {
    
    // MARK: - Initialize View Model
    
    func initViewModel() {
       viewModel = GarmentListViewModel(databaseAccess: .init()) { [weak self] () in
            guard let self = self else {
                return
            }
            self.viewModel.fetchProducts()
       }
        // View Model closure
        reloadTableViewClosure()
    }
    
    // MARK: - View Model Closure
    
    func reloadTableViewClosure() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension GarmentListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse or create a cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Fetch data needed to display the row
        let cellData = viewModel.dataForRow(at: indexPath)
        cell.textLabel?.text = cellData.text
        cell.textLabel?.textAlignment = cellData.alignment
             
        return cell
    }

}
