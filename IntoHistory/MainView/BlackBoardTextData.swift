//
//  BlackBoardTextData.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/17.
//

enum Holiday: String {
    case samiljeol = "0301" // 31절
    case hyukmeong419 = "0419" // 419혁명
    case minju518 = "0518" // 518민주항쟁
    case hyunchoongil = "0606" // 현충일
    case minju610 = "0610" // 610민주화운동
    case koreawar = "0625" // 625
    case jaehunjul = "0717" // 제헌절
    case gwangbokjul = "0816" // 광복절
    case militarynal = "1001" // 국군의날
    case gaechunjul = "1003"  // 개천절
    case hanguelnal = "1009"  // 한글날
    case sunkook = "1117"    // 순국선열의날

    var boardContent: String {
        switch self {
        case .samiljeol:
            return "오늘은 '삼일절'입니다. \n일제강점기였던 1919년 3월 1일 토요일에 일본제국주의에 항거해 한국의 독립을 선언한 독립선언일입니다."
        case .hyukmeong419:
            return "'4·19혁명'을 기억합시다. \n대한민국에서 이승만 정권의 독재에 항거해 시민들이 들고 일어나서 대한민국 제1공화국을 끝낸 민주주의 시민 혁명이다."
        case .minju518:
            return "오늘은 '5·18민주화운동'이 일어난 날입니다. \n1980년 5월 18일부터 5월 27일까지 전라도민이 중심이 되어,민주화를 위해 싸운 날입니다."
        case .hyunchoongil:
            return "오늘은 '현충일'입니다. \n나라를 위해 희생한 순국선열과 전몰한 장병들의 충렬을 기리고 얼을 위로 하는 날입니다."
        case .minju610:
            return "'6·10 민주항쟁'. \n전두환 정권에 맞서 전국에서 일어난 일련의 민주화 운동입니다."
        case .koreawar:
            return "오늘은 '6·25'전쟁이 일어난 날 입니다. \n1950년 6월 25일 오전 4시에 조선민주주의인민공화국이 기습적으로 대한민국을 침공(남침)하여 발발한 전쟁입니다."
        case .jaehunjul:
            return "오늘은 '제헌절'입니다. \n대한민국 헌법(제헌 헌법)이 제정, 공포된 것을 기념하는 날입니다."
        case .gwangbokjul:
            return "오늘은 '광복절'입니다. \n한반도가 일본 제국으로부터 해방된 것을 기념하는 날입니다. 대한민국 만세!"
        case .militarynal:
            return "오늘은 '국군의 날'입니다. \n대한민국 국군의 발전을 기념하는 날입니다."
        case .gaechunjul:
            return "오늘은 '개천절'입니다. \n 한국 역사에서 첫 국가인 고조선을 기념하는 날입니다."
        case .hanguelnal:
            return "오늘은 '한글날'입니다. \n훈민정음의 반포를 기념하는 날입니다."
        case .sunkook:
            return "오늘은 '순국 선열의 날'입니다. \n국권회복을 위해 헌신하신 순국선열의 독립정신과 희생정신을 기리는 날입니다."
        }
    }
}
