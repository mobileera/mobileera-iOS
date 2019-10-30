import UIKit

protocol CustomSegmentedControlDelegate: class {
    func customSegmentedControl(_ customSegmentedControl: CustomSegmentedControl, didSelectDayAtIndex index: Int)
}

class CustomSegmentedControl: UIView {
    weak var delegate: CustomSegmentedControlDelegate?

    lazy var daySegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Day 1", "Day 2"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(onSegmentControlValueChanged), for: .valueChanged)
        segmentControl.layer.cornerRadius = segmentControl.frame.height / 2
        segmentControl.clipsToBounds = true

        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)

        return segmentControl
    }()

    @objc func onSegmentControlValueChanged() {
        delegate?.customSegmentedControl(self, didSelectDayAtIndex: daySegmentControl.selectedSegmentIndex)
    }

    override var intrinsicContentSize: CGSize {
      return UIView.layoutFittingExpandedSize
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let margin: CGFloat = 6
        addSubview(daySegmentControl)
        NSLayoutConstraint.activate([
            daySegmentControl.topAnchor.constraint(equalTo: topAnchor),
            daySegmentControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            daySegmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin * 2),
            daySegmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin * 2)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
