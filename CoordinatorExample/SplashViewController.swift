import Foundation
import UIKit

public protocol SplashViewControllerDelegate: class {
    func splashViewControllerDidTapNewOrder(splashViewController: SplashViewController)
}

public class SplashViewController: UIViewController {
    
    private let services: Services
    
    public weak var delegate: SplashViewControllerDelegate?
    
    private var titleLabel: UILabel = UILabel()
    
    public init(services: Services) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let newOrderButton = UIButton(type: .system)
        newOrderButton.setTitle("New order", for: .normal)
        newOrderButton.backgroundColor = .red
        newOrderButton.addTarget(self, action: #selector(didTapNewOrder), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(newOrderButton)
        newOrderButton.translatesAutoresizingMaskIntoConstraints = false
        newOrderButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        newOrderButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        newOrderButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.titleLabel.numberOfLines = 0
        self.view.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        self.updateView()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }
    
    private func updateView() {
        
        let orderCount = self.services.dataService.orders.count
        
        self.titleLabel.attributedText = self.attributedOrderString(orderCount: orderCount)
    }
    
    private func attributedOrderString(orderCount: Int) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 20
        
        let fontAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 40)
        ]
        
        let largeFontAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 70)
        ]
        
        let string = NSMutableAttributedString()
        
        string.append(NSAttributedString(string: "Orders in Progress\n", attributes: fontAttributes))
        
        
        string.append(NSAttributedString(string: "\(orderCount)", attributes: largeFontAttributes))
        
        return string
    }
    
    @objc private func didTapNewOrder(sender: UIButton) {
        self.delegate?.splashViewControllerDidTapNewOrder(splashViewController: self)
    }
    
}
