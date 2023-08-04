import UIKit
import Neuro_ID

class SearchCityController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var datasource = [City]() {
        didSet {
            tableView.reloadData()
        }
    }
    var originalDatasource = [City]()
    var selectCityAction: ((City) -> Void)?

    deinit {
        print("Deinit \(String(describing: self))")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    func setupView() {
        navigationController?.navigationBar.isHidden = false
        searchBar.id = "searchBar"
        tableView.id = "cityList"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityCell.self, forCellReuseIdentifier: "CityCell")
    }

    func getData() {
        datasource = DataRepository.getCity()
    }
}

extension SearchCityController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.setData(datasource[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = datasource[indexPath.row]
//        tracker?.captureEvent(event: NIDEvent(customEvent: NIDEventName.selectChange.rawValue, tg: ["index": indexPath.row], view: tableView))
        selectCityAction?(city)
        navigationController?.popViewController(animated: true)
    }
}

class CityCell: UITableViewCell {
    func setData(_ data: City) {
        textLabel?.text = data.city_name
    }
}
