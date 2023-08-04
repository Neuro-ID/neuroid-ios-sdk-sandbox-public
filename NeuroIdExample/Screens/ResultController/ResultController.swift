import UIKit
import Neuro_ID

class ResultController: UITableViewController {
    var datasource = [Hotel]() {
        didSet {
            tableView.reloadData()
        }
    }

    deinit {
        print("Deinit \(String(describing: self))")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    func setupView() {
        tableView.id = "hotelList"
        navigationController?.navigationBar.isHidden = false
    }

    func getData() {
        datasource = DataRepository.getHotels()
    }
}

extension ResultController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelCell", for: indexPath) as! HotelCell
        cell.setData(datasource[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotelDetail = datasource[indexPath.row].hotel_name
        let vc = UIAlertController(title: "View detail", message: hotelDetail, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(vc, animated: true)
//        tracker?.captureEvent(event: NIDEvent(customEvent: "ViewHotelDetail", tg: ["index": indexPath.row], view: tableView))
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

class HotelCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func setData(_ data: Hotel) {
        nameLabel.text = data.hotel_name
        ratingLabel.text = data.hotel_star_rating
        priceLabel.text = "$\(data.hotel_min_price) - $\(data.hotel_max_price)"
        descriptionLabel.text = data.hotel_desc
    }
}
