import UIKit

protocol CarStoreDelegate: AnyObject {
    func addToBasket(car: Car)
}

class CarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var carTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier)
        table.rowHeight = 100
        return table
    }()
    
    weak var delegate: CarStoreDelegate?
    
    var carsInStore = [
        Car(id: UUID(), modelName: "BMW", price: 15, imageDescription: "Black"),
        Car(id: UUID(), modelName: "Audi", price: 10, imageDescription: "White"),
        Car(id: UUID(), modelName: "KIA", price: 5, imageDescription: "Gray"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carTableView.dataSource = self
        carTableView.delegate = self
        
        view.backgroundColor = .white
        
        view.addSubview(carTableView)
        setupLayout()
        setupNavigationBar()
        
    }
    
    func setupNavigationBar() {
        navigationItem.title = "STORE"

        let toBasketAction = UIAction { [weak self] _ in
            let basketViewController = BasketViewController()
            self?.navigationController?.pushViewController(basketViewController, animated: true)
        }
        let basketBarButtonItem = UIBarButtonItem(title: "Basket", primaryAction: toBasketAction)
        
        navigationItem.rightBarButtonItem = basketBarButtonItem
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            carTableView.topAnchor.constraint(equalTo: view.topAnchor),
            carTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            carTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsInStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell
        let car = carsInStore[indexPath.row]
        cell.configureCell(car: car)
        cell.setupButtonActions()
        
        cell.addButtonAction = { [weak self] in
            let choosenCar = Car(id: UUID(), modelName: (self?.carsInStore[indexPath.row].modelName)!, price: (self?.carsInStore[indexPath.row].price)!, imageDescription: (self?.carsInStore[indexPath.row].imageDescription)!)
            self?.delegate?.addToBasket(car: choosenCar)
        }
        return cell
    }
    
}
