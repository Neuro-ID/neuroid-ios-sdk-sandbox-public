import UIKit
import Neuro_ID

class FilterController: UIViewController {
    @IBOutlet weak var star1View: UIView!
    @IBOutlet weak var star2View: UIView!
    @IBOutlet weak var star3View: UIView!
    @IBOutlet weak var star4View: UIView!
    @IBOutlet weak var star5View: UIView!
    @IBOutlet weak var star1Label: UILabel!
    @IBOutlet weak var star1StarImage: UIImageView!
    @IBOutlet weak var star2Label: UILabel!
    @IBOutlet weak var star3Label: UILabel!
    @IBOutlet weak var star4Label: UILabel!
    @IBOutlet weak var star5Label: UILabel!
    @IBOutlet weak var star2StarImage: UIImageView!
    @IBOutlet weak var star3StarImage: UIImageView!
    @IBOutlet weak var star4StarImage: UIImageView!
    @IBOutlet weak var star5StarImage: UIImageView!
    @IBOutlet weak var priceRangeSlider: RangeSlider!
    @IBOutlet weak var lowerPriceLabel: UILabel!
    @IBOutlet weak var higherPriceLabel: UILabel!
    @IBOutlet weak var hotelStarRatingLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!

    deinit {
        print("Deinit \(String(describing: self))")
    }

    var filterOption: FilterOption?
    var didSelectOption: ((FilterOption?) -> Void)?
    var selectedStars = [Int: Bool]() {
        didSet {
            let stars = selectedStars.compactMap {
                return $0.value ? $0.key : nil
            }
            if filterOption == nil {
                filterOption = FilterOption()
            }
            filterOption?.stars = stars
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello!")
//        NeuroID.stop()
        setupView()
    }

    func setupView() {
        star1StarImage.id = "star1"
        star2StarImage.id = "star2"
        star3StarImage.id = "star3"
        star4StarImage.id = "star4"
        star5StarImage.id = "star5"

        navigationController?.navigationBar.isHidden = false
        let star1Tap = UITapGestureRecognizer(target: self, action: #selector(clickedStar1View))
        star1View.addGestureRecognizer(star1Tap)

        let star2Tap = UITapGestureRecognizer(target: self, action: #selector(clickedStar2View))
        star2View.addGestureRecognizer(star2Tap)

        let star3Tap = UITapGestureRecognizer(target: self, action: #selector(clickedStar3View))
        star3View.addGestureRecognizer(star3Tap)

        let star4Tap = UITapGestureRecognizer(target: self, action: #selector(clickedStar4View))
        star4View.addGestureRecognizer(star4Tap)

        let star5Tap = UITapGestureRecognizer(target: self, action: #selector(clickedStar5View))
        star5View.addGestureRecognizer(star5Tap)

        okButton.setTitleColor(Colors.colorTextAlt, for: .normal)
        okButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        okButton.backgroundColor = Colors.colorPrimary

        [
            star1Label,
            star2Label,
            star3Label,
            star4Label,
            star5Label
        ].forEach {
            $0?.font = .systemFont(ofSize: 13)
            $0?.textColor = Colors.colorText
        }

        hotelStarRatingLabel.textColor = Colors.colorText

        priceTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        priceTitleLabel.textColor = Colors.colorText

        lowerPriceLabel.font = .systemFont(ofSize: 11)
        lowerPriceLabel.textColor = Colors.colorText

        higherPriceLabel.font = .systemFont(ofSize: 11)
        higherPriceLabel.textColor = Colors.colorText
    }

    @IBAction func priceSliderValueChanged(_ priceSlider: RangeSlider) {
        priceTitleLabel.text = "$\(Int(priceSlider.lowerValue)) - $\(Int(priceSlider.upperValue))"
        if filterOption == nil {
            filterOption = FilterOption()
        }
        filterOption?.lowerPrice = Int(priceSlider.lowerValue)
        filterOption?.upperPrice = Int(priceSlider.upperValue)

        tracker?.captureEvent(event: NIDEvent(type: .sliderChange, tg: ["lowerValue": TargetValue.double(priceSlider.lowerValue), "upperValue": TargetValue.double(priceSlider.upperValue)], view: priceSlider))
    }

    func toggleStar(index: Int, isSelected: Bool) {
        let dict = [
            1: (view: star1View, label: star1Label, icon: star1StarImage),
            2: (view: star2View, label: star2Label, icon: star2StarImage),
            3: (view: star3View, label: star3Label, icon: star3StarImage),
            4: (view: star4View, label: star4Label, icon: star4StarImage),
            5: (view: star5View, label: star5Label, icon: star5StarImage)
        ]

        let star = dict[index]
        if isSelected {
            star?.view?.backgroundColor = Colors.colorWhite
            star?.label?.textColor = Colors.colorText
            star?.icon?.image = UIImage(named: "Star-Icon")
            selectedStars[index] = false
            tracker?.captureEventCheckBoxChange(isChecked: false, checkBox: star!.icon!)
        } else {
            star?.view?.backgroundColor = Colors.colorHightLight
            star?.label?.textColor = Colors.colorWhite
            star?.icon?.image = UIImage(named: "StarWhite-Icon")
            selectedStars[index] = true
            tracker?.captureEventCheckBoxChange(isChecked: true, checkBox: star!.icon!)
        }
    }

    @objc func clickedStar1View() {
        let index = 1
        toggleStar(index: index, isSelected: selectedStars[index] ?? false)
    }

    @objc func clickedStar2View() {
        let index = 2
        toggleStar(index: index, isSelected: selectedStars[index] ?? false)
    }

    @objc func clickedStar3View() {
        let index = 3
        toggleStar(index: index, isSelected: selectedStars[index] ?? false)
    }

    @objc func clickedStar4View() {
        let index = 4
        toggleStar(index: index, isSelected: selectedStars[index] ?? false)
    }

    @objc func clickedStar5View() {
        let index = 5
        toggleStar(index: index, isSelected: selectedStars[index] ?? false)
    }

    @IBAction func okClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        didSelectOption?(filterOption)
    }

}
