import UIKit

class CarTableViewCell: UITableViewCell {
    
    lazy var modelNameLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        return text
    }()
    lazy var priceLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
//        text.textColor = .gray
        return text
    }()
    lazy var imageDescriptionLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
//        text.textColor = .gray
        return text
    }()
    
    lazy var addToBasketButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .lightGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    var addButtonAction: (() -> Void)?
    @objc func addButtonTapped() {
        addButtonAction?()
    }
    func setupButtonActions() {
        addToBasketButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(car: Car) {
        modelNameLabel.text = car.modelName
        priceLabel.text = String(car.price) + "$"
        imageDescriptionLabel.text = car.imageDescription
        
    }
    
    func setupLayout() {
        
        contentView.addSubview(modelNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(imageDescriptionLabel)
        contentView.addSubview(addToBasketButton)

        
        NSLayoutConstraint.activate([
            
            modelNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            modelNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            modelNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageDescriptionLabel.leadingAnchor.constraint(equalTo: modelNameLabel.trailingAnchor, constant: 15),
            imageDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            addToBasketButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addToBasketButton.widthAnchor.constraint(equalToConstant: 50),
            addToBasketButton.heightAnchor.constraint(equalToConstant: 50),
            addToBasketButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: addToBasketButton.leadingAnchor, constant: -15),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
}
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
