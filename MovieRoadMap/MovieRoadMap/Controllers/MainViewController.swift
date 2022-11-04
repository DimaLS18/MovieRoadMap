//
//  ViewController.swift
//  MovieRoadMap
//
//  Created by Dima Kovrigin on 25.10.2022.
//
import UIKit
///  Контроллер начального экрана

final class MainViewController: UIViewController {
    // MARK: - Private Enum
    private enum Constants {
        static let popular = "Популярноe"
        static let topRated = "Toп"
        static let upcoming = "Скоро"
        static let cellIdentifier = "cell"
        static let movies = "ФИЛЬМЫ"
        static let keyValue = "e81faf355027f9ca91258698400315ed"
        static let key = "apiKey"
    }

    // MARK: - Private Visual Components
    private lazy var popularButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.popular, for: .normal)
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 15
        button.tag = 0
        button.addTarget(self, action: #selector(updateTableView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var topRatedButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.addTarget(self, action: #selector(updateTableView), for: .touchUpInside)
        button.setTitle(Constants.topRated, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var upcomingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.upcoming, for: .normal)
        button.backgroundColor = .black
        button.tag = 2
        button.addTarget(self, action: #selector(updateTableView), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }()

    lazy var closure: ((UIImage) -> ())? = { [weak self] image in
        self?.tableView.backgroundView = UIImageView(image: image)
    }
    private let loadFilmService = Service()
    private var pageInfo: Int?
    private var films: [FilmInfo] = []


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    // MARK: - Private methods
    private func loadFilmsData() {
        UserDefaults.standard.set(Constants.keyValue, forKey: Constants.key)
        Service.shared.loadFilms(page: 1, api: PurchaseEndPoint.popular) { [weak self] result in
            self?.films = result.results
            self?.pageInfo = result.pageCount
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(popularButton)
        view.addSubview(topRatedButton)
        view.addSubview(upcomingButton)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        createConstraint()
        navigationItem.title = Constants.movies
    }

    private func createConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: popularButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),

            popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            popularButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            popularButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 80) / 3),
            popularButton.heightAnchor.constraint(equalToConstant: 40),

            topRatedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            topRatedButton.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 20),
            topRatedButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 80) / 3),
            topRatedButton.heightAnchor.constraint(equalToConstant: 40),

            upcomingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            upcomingButton.leadingAnchor.constraint(equalTo: topRatedButton.trailingAnchor, constant: 20),
            upcomingButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 80) / 3),
            upcomingButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func reloadButtons() {
        popularButton.backgroundColor = .black
        topRatedButton.backgroundColor = .black
        upcomingButton.backgroundColor = .black
    }

    @objc private func updateTableView(sender: UIButton) {
        reloadButtons()
        sender.backgroundColor = .systemGray
        var category: PurchaseEndPoint {
            switch sender.tag {
            case 0: return .popular
            case 1: return .topRated
            case 2: return .upcoming
            default:
                return .popular
            }
        }

        loadFilmService.loadFilms(page: 1, api: category) { [weak self] result in
            self?.pageInfo = result.pageCount
            self?.films = result.results
            DispatchQueue.main.async {
        self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - extension UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? FilmTableViewCell {
            cell.setupData(data: films[indexPath.row])
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let fvc = FilmViewController()
        fvc.filmIndex = films[row].id
        navigationController?.pushViewController(fvc, animated: true)
    }
}
