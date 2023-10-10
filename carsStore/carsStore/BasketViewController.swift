import UIKit

class BasketViewController: UIViewController, UITableViewDelegate {
    
    enum TableSection {
        case main
    }
    
    lazy var basketTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier)
        table.rowHeight = 100
        return table
    }()
    lazy var sumLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        return text
    }()
    lazy var countLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        return text
    }()
    

    var carsInBasket = [Car] ()
    var dataSource: UITableViewDiffableDataSource<TableSection, Car>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(basketTableView)
        view.addSubview(sumLabel)
        view.addSubview(countLabel)

        setupLayout()
        setupDataSource()
        setupNavigationBar()

    }

    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: basketTableView, cellProvider: { basketTableView, indexPath, car in
            
            let cell = basketTableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell
            cell.configureCell(car: car)
            
            cell.addButtonAction = { [weak self] in
                if let carToDelete = self?.dataSource?.itemIdentifier(for: indexPath) {
                    if let indexToDelete = self?.carsInBasket.firstIndex(of: carToDelete) {
                        self?.carsInBasket.remove(at: indexToDelete)
                    }
                }
            }
            return cell
        })
        
        updateDataSource(with: carsInBasket, animate: false)
    }
                        
    
    func updateDataSource(with cars: [Car], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Car>()
        snapshot.appendSections([.main])
        snapshot.appendItems(carsInBasket)
        dataSource?.apply(snapshot, animatingDifferences: animate)
        countLabel.text = "Количество: " + String(carsInBasket.count)
        sumLabel.text = "Сумма: " + String(carsInBasket.reduce(0) { $0 + $1.price })
    }
    
    func setupNavigationBar() {
        navigationItem.title = "BASKET"
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            basketTableView.topAnchor.constraint(equalTo: view.topAnchor),
            basketTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basketTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            basketTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            sumLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            sumLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            sumLabel.heightAnchor.constraint(equalToConstant: 60),
            sumLabel.widthAnchor.constraint(equalToConstant: 120),
            
            countLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            countLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            countLabel.heightAnchor.constraint(equalToConstant: 60),
            countLabel.widthAnchor.constraint(equalToConstant: 120),


        ])
    }
}
extension BasketViewController: CarStoreDelegate {
    func addToBasket(car: Car) {
        guard (dataSource?.snapshot()) != nil else { return }
        let CarVC = CarViewController()
        if CarVC.carsInStore.firstIndex(where: { $0.id == car.id }) != nil {
            carsInBasket.append(car)
        }
        updateDataSource(with: carsInBasket, animate: false)
    }
}
