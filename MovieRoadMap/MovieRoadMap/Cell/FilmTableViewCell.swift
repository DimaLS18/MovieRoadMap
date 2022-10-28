//
//  FilmTableViewCell.swift
//  MovieRoadMap
//
//  Created by Dima Kovrigin on 26.10.2022.
//

import UIKit

///ячейка  таблицы на начальном контроллере
final class FilmTableViewCell: UITableViewCell {

    // MARK: - Private Visual Components
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private var filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var rateView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemRed
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var boxView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = UITableViewCell.SelectionStyle.none
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(data: FilmInfo) {
        nameLabel.text = data.title
        descriptionLabel.text = data.overview
        rateLabel.text = "\(data.rate)"
        filmImageView.loadImage(with: data.poster)

    }

    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubview(boxView)
        boxView.addSubview(nameLabel)
        boxView.addSubview(descriptionLabel)
        boxView.addSubview(filmImageView)
        filmImageView.addSubview(rateView)
        rateView.addSubview(rateLabel)
        createConstraints()

    }

    private func createConstraints() {
        NSLayoutConstraint.activate([
        boxView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        boxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
        boxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        boxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        boxView.heightAnchor.constraint(equalToConstant: filmImageView.bounds.height + 20),

        filmImageView.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 0),
        filmImageView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 0),
        filmImageView.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 0),
        filmImageView.widthAnchor.constraint(equalTo: filmImageView.heightAnchor, multiplier: 0.7),

        nameLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 10),
        nameLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20),
        nameLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20),

        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
        descriptionLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10),
        descriptionLabel.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -10),
        descriptionLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10),

        rateView.leadingAnchor.constraint(equalTo: filmImageView.leadingAnchor, constant: -5),
        rateView.topAnchor.constraint(equalTo: filmImageView.topAnchor, constant: -5),
        rateView.widthAnchor.constraint(equalToConstant: 45),
        rateView.heightAnchor.constraint(equalTo: rateView.widthAnchor, multiplier: 0.8),

        rateLabel.centerYAnchor.constraint(equalTo: rateView.centerYAnchor, constant: 2.5),
        rateLabel.centerXAnchor.constraint(equalTo: rateView.centerXAnchor, constant: 2.5),
        rateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
