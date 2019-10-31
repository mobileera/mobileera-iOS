import UIKit

protocol LocationsViewDelegate: class {
    func locationsView(_ locationsView: LocationsView, didSelectFelix1 isSelected: Bool)
    func locationsView(_ locationsView: LocationsView, didSelectFelix2 isSelected: Bool)
    func locationsView(_ locationsView: LocationsView, didSelectLancing isSelected: Bool)
}

class LocationsView: UIView {
    weak var delegate: LocationsViewDelegate?

    var isFelix1Selected: Bool = false {
        didSet {
            updateColor(button: felix1Button, color: R.color.felix1Color(), isSelected: isFelix1Selected)
        }
    }

    var isFelix2Selected: Bool = false {
        didSet {
            updateColor(button: felix2Button, color: R.color.felix2Color(), isSelected: isFelix2Selected)
        }
    }
    var isLancingSelected: Bool = false {
        didSet {
            updateColor(button: lancingButton, color: R.color.lancingColor(), isSelected: isLancingSelected)
        }
    }

    func updateColor(button: UIButton, color: UIColor?, isSelected: Bool) {
        button.setTitleColor(isSelected ? .white : color, for: .normal)
        button.setBackgroundColor(isSelected ? color : .white, for: .normal)
    }

    func styledButton(color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)

        button.setTitleColor(color, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setTitleColor(.white, for: .selected)

        button.setBackgroundColor(.white, for: .normal)
        button.setBackgroundColor(color.withAlphaComponent(0.4), for: .highlighted)
        button.setBackgroundColor(color, for: .selected)

        button.clipsToBounds = true
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 15

        return  button
    }

    lazy var felix1Button: UIButton = {
        let button = styledButton(color: R.color.felix1Color()!)
        button.setTitle("Felix 1", for: .normal)
        button.addTarget(self, action: #selector(felix1ButtonTapped), for: .touchUpInside)
        return  button
    }()

    lazy var felix2Button: UIButton = {
        let button = styledButton(color: R.color.felix2Color()!)
        button.setTitle("Felix 2", for: .normal)
        button.addTarget(self, action: #selector(felix2ButtonTapped), for: .touchUpInside)
        return  button
    }()


    lazy var lancingButton: UIButton = {
        let button = styledButton(color: R.color.lancingColor()!)
        button.setTitle("Lancing", for: .normal)
        button.addTarget(self, action: #selector(lancingButtonTapped), for: .touchUpInside)
        return  button
    }()

    @objc func felix1ButtonTapped() {
        isFelix1Selected = !isFelix1Selected
        delegate?.locationsView(self, didSelectFelix1: isFelix1Selected)
    }

    @objc func felix2ButtonTapped() {
        isFelix2Selected = !isFelix2Selected
        delegate?.locationsView(self, didSelectFelix2: isFelix2Selected)
    }

    @objc func lancingButtonTapped() {
        isLancingSelected = !isLancingSelected
        delegate?.locationsView(self, didSelectLancing: isLancingSelected)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        NSLayoutConstraint.activate([
            felix1Button.heightAnchor.constraint(equalToConstant: 30),
            felix2Button.heightAnchor.constraint(equalToConstant: 30),
            lancingButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        let margin: CGFloat = 8
        let stackView = UIStackView(arrangedSubviews: [felix1Button, felix2Button, lancingButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin * 2),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin * 2)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        guard let color = color else { return }
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
}
