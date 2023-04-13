//
//  StudentShowMealsView.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/29.
//

import UIKit
import SnapKit
import Then
import Alamofire

class StudentShowMealsVC: UIViewController {
    let dateLabel = UILabel().then {
        $0.text = "2023년 04월 06일"
    }
    let breakfast = UIView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .systemRed
    }
    let breakfastImage = UIImageView().then {
        $0.image = UIImage(named: "")
        $0.backgroundColor = .blue
    }
    let breakfastLabel = UILabel().then {
        $0.text = "아침급식이 없습니다 아침급식이 없습니다 아침급식이 없습니다 아침급식이 없습니다"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 0
    }

    let lunch = UIView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .systemRed
    }
    let lunchImage = UIImageView().then {
        $0.image = UIImage(named: "")
        $0.backgroundColor = .blue
    }
    let lunchLabel = UILabel().then {
        $0.text = "점심급식이 없습니다 점심급식이 없습니다 점심급식이 없습니다 점심급식이 없습니다"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 0
    }

    let dinner = UIView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .systemRed
    }
    let dinnerImage = UIImageView().then {
        $0.image = UIImage(named: "")
        $0.backgroundColor = .blue
    }
    let dinnerLabel = UILabel().then {
        $0.text = "저녁급식이 없습니다 저녁급식이 없습니다 저녁급식이 없습니다 저녁급식이 없습니다"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()

    }


}

extension StudentShowMealsVC {
    func setup() {
        [
            breakfast,
            lunch,
            dinner,
            breakfastImage,
            lunchImage,
            dinnerImage,
            breakfastLabel,
            lunchLabel,
            dinnerLabel
        ].forEach{self.view.addSubview($0)}
        breakfast.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalTo(breakfast.snp.top).offset(140)
        }
        breakfastImage.snp.makeConstraints {
            $0.top.equalTo(breakfast.snp.top).offset(30)
            $0.left.equalTo(breakfast.snp.left).offset(20)
            $0.right.equalTo(breakfastImage.snp.left).offset(80)
            $0.bottom.equalTo(breakfast.snp.bottom).offset(-30)
        }
        breakfastLabel.snp.makeConstraints {
            $0.top.equalTo(breakfast.snp.top).offset(50)
            $0.left.equalTo(breakfastImage.snp.right).offset(20)
            $0.right.equalTo(breakfastLabel.snp.left).offset(180)
            $0.bottom.equalTo(breakfast.snp.bottom).offset(-50)
        }
        lunch.snp.makeConstraints {
            $0.top.equalTo(breakfast.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalTo(lunch.snp.top).offset(140)
        }
        lunchImage.snp.makeConstraints {
            $0.top.equalTo(lunch.snp.top).offset(30)
            $0.left.equalTo(lunch.snp.left).offset(20)
            $0.right.equalTo(lunchImage.snp.left).offset(80)
            $0.bottom.equalTo(lunch.snp.bottom).offset(-30)
        }
        lunchLabel.snp.makeConstraints {
            $0.top.equalTo(lunch.snp.top).offset(50)
            $0.left.equalTo(lunchImage.snp.right).offset(20)
            $0.right.equalTo(lunchLabel.snp.left).offset(180)
            $0.bottom.equalTo(lunch.snp.bottom).offset(-50)
        }
        dinner.snp.makeConstraints {
            $0.top.equalTo(lunch.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalTo(dinner.snp.top).offset(140)
        }
        dinnerImage.snp.makeConstraints {
            $0.top.equalTo(dinner.snp.top).offset(30)
            $0.left.equalTo(dinner.snp.left).offset(20)
            $0.right.equalTo(dinnerImage.snp.left).offset(80)
            $0.bottom.equalTo(dinner.snp.bottom).offset(-30)
        }
        dinnerLabel.snp.makeConstraints {
            $0.top.equalTo(dinner.snp.top).offset(50)
            $0.left.equalTo(dinnerImage.snp.right).offset(20)
            $0.right.equalTo(dinnerLabel.snp.left).offset(180)
            $0.bottom.equalTo(dinner.snp.bottom).offset(-50)
        }
    }
    
    func getMeals() {
        
    }
    //    func request<T: Decodable>( url: String,
    //                                           method: HTTPMethod,
    //                                           params: [String: Any]? = nil,
    //                                           _ model: T.Type,
    //                                           completion: @escaping (T) -> Void) {
    //            print("함수 호출")
    //            AF.request(url,
    //                       method: method,
    //                       parameters: params,
    //                       encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
    //                       interceptor: Interceptor()
    //            )
    //            .responseData { response in
    //                switch response.result {
    //                case .success:
    //                    self.present()
    //                    print("성공")
    //                    if let data = response.data {
    //                        let decoder = JSONDecoder()
    //                        let dateFormatter = DateFormatter()
    //                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    //                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
    //                        print(String(decoding: response.data!, as: UTF8.self))
    //                        if let decodedData = try? decoder.decode(T.self, from: data) {
    //                            DispatchQueue.main.async {
    //                                completion(decodedData)
    //                            }
    //                        }
    //                    }
    //                case .failure(let error):
    //                    print(error)
    //                }
    //            }
    //        }
    //    }
}

