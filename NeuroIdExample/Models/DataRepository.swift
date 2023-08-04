//
//  DataRepository.swift
//  PSHotels
//
//  Created by Ky Nguyen on 6/30/21.
//  Copyright © 2021 Panacea-soft. All rights reserved.
//

import Foundation
class DataRepository {
    
    static func getHotels() -> [Hotel] {
        let names = [
            "Four Seasons Resort Lanai",
            "Acqualina Resort & Residences on the Beach",
            "The Peninsula Chicago",
            "The Beverly Hills Hotel",
            "The Langham, Chicago",
        ]
        
        let descriptions = [
            "Situated on the banks of the Chicago River and less than a mile from the shopping on The Magnificent Mile, The Langham, Chicago is a hit with recent travelers. Opened in 2013, the hotel impresses guests with its attentive service, quiet location and riverfront views. Occupying the first 13 floors of a 52-story landmark skyscraper, The Langham, Chicago boasts 316 guest rooms and suites. Accommodations are outfitted with soaking tubs and rain showers, flat-screen TVs and complimentary Wi-Fi access. Past lodgers compliment the comfy beds and relaxing bathrooms and recommend booking a room with a river view to make the most of the hotel's location. When you're not relaxing in your room, you'll find plenty of other amenities at your fingertips. In addition to the Chuan Spa, the hotel also touts a health club and 67-foot-long indoor pool. Though many of downtown Chicago's top restaurants are within reach, previous visitors suggest giving the on-site restaurant, Travelle, a try. As is the case throughout the property, guests say the service staff members at the restaurant are both attentive and friendly.",
            "The Beverly Hills Hotel is iconic to La-La Land lore, made famous by The Eagles tune Hotel California. But the Pink Palace has racked up quite a few fabled stories: Katharine Hepburn is said to have jumped into the pool fully clothed, and Elizabeth Taylor enjoyed six honeymoons here. Today, this Dorchester Collection hotel continues to cater to discerning travelers with stylish guest rooms (equipped with marble bathrooms, flat-screen TVs, high-speed internet access and gourmet minibars), business amenities and a supreme Sunset Boulevard location. Travelers say the customer service is just as legendary as the hotel itself, praising the hotel staff for its attentiveness. And the on-site Polo Lounge is not only known for its celeb-spotting – it's known for serving up a mean breakfast as well.",
            "Occupying prime real estate on Chicago's coveted Magnificent Mile, The Peninsula Chicago combines Hong Kong's cosmopolitan flair with the Windy City's Midwestern charm. Travelers describe the guest rooms as comfortable thanks to their creamy color palette and plush furniture, not to mention their modern techie touches, like a bedside remote command station that controls the lights, television and room temperatures. Meanwhile, the renowned Peninsula Spa is in a class by itself, earning The Peninsula Chicago many accolades from health and leisure magazines. Another honorable mention goes to the afternoon tea served in the lobby bar, which visitors say is a nice and welcome touch. During your stay, guests recommend making time for the tasty Cantonese dishes served in the Shanghai Terrace restaurant. However, for many travelers, it was The Peninsula Chicago's friendly service staff that convinced them to stay here again.",
            "This spa resort doesn't take any of its five stars for granted, particularly when it comes to delivering first-rate customer service. Guests can't help but keep the compliments coming: Travelers say the resort staff takes extra care to personalize each experience. However, one problem you might face is exclusivity. Acqualina Resort & Residences on the Beach only has 98 guest rooms and suites, so be sure to book early for an upcoming trip to Sunny Isles Beach, Florida. The rooms come with flat-screen TVs and private balconies, as well as double sinks and glass-enclosed showers. Meanwhile, the property also features two in-house eateries, a grab-and-go market, four pools, a spa and beach amenities. What's more, the hotel is part of The Leading Hotels of the World, meaning Leaders Club members have access to perks here. You'll find Acqualina Resort & Residences on the Beach about 10 miles north of Miami Beach.",
            "This Four Seasons property attracts beach lovers. Positioned along a beautiful stretch of Hulopoe Bay sand overlooking the Pacific Ocean, this resort offers breathtaking ocean views, manicured grounds and top-notch customer service. During their stays, guests can enjoy outdoor pursuits, such as snorkeling, deep-sea fishing, hiking, whale watching, scuba diving and more. Visitors use terms like paradise and heaven on earth to describe the property. Guest rooms all feature private patios, as well as amenities like 75-inch flat-screen TVs with Blu-ray players, Nespresso machines and free internet access. One of the most loved features is the complimentary shuttle, which will cart you to and from Lanai Town. Recent visitors do say you should brace yourself for the high cost of meals at the resort's multiple restaurants and treatments at the in-house spa. Still, most travelers enjoy this Four Seasons resort's piece of shoreline and its world-class golf course.",
        ]
        
        let addresses = [
            "1 Manele Bay RoadLanai City, HI 96763",
            "17875 Collins Ave. Sunny Isles Beach, FL 33160-2718",
            "108 E Superior St at North Michigan Avenue Chicago, IL 60611-2645",
            "9641 Sunset Blvd Beverly Hills, CA 90210-2938",
            "330 North Wabash Avenue Chicago, IL 60611",
        ]
        
        let hotels = Array(0 ..< 20).map { _ in
            Hotel(hotel_id: randomId(),
                         city_id: randomId(),
                         hotel_name: names.randomElement()!,
                         hotel_desc: descriptions.randomElement()!,
                         hotel_address: addresses.randomElement()!,
                         hotel_lat: getLat(),
                         hotel_lng: getLong(),
                         hotel_phone: "",
                         hotel_email: "",
                         hotel_min_price: String(Int.random(in: 100 ... 400)),
                         hotel_max_price: String(Int.random(in: 500 ... 1000)),
                         hotel_star_rating: String(Int.random(in: 1...5)),
                         hotel_check_in: "14:00",
                         hotel_check_out: "12:00",
                         is_recommended: "true",
                         status: "Available",
                         added_date: "",
                         added_date_str: "",
                         currency_symbol: "$",
                         currency_short_form: "USD",
                         touch_count: "1213",
                         image_count: "0",
                         is_user_favourited: "false")
        }
        
        return hotels
    }
    
    static func randomId() -> String {
        UUID().uuidString
    }
    
    static func getLat() -> String {
        let base = 38.8951
        let isNagative = Date().timeIntervalSinceNow / 2 == 0
        let diff = Double.random(in: 0.4 ... 0.8) * (isNagative ? -1 : 1)
        return String(base + diff)
    }
    
    static func getLong() -> String {
        let base = -77.0364
        let isNagative = Date().timeIntervalSinceNow / 2 == 0
        let diff = Double.random(in: 0.4 ... 0.8) * (isNagative ? -1 : 1)
        return String(base + diff)
    }
    
    static func getCity() -> [City] {
        let names = [
            "New York",
            "Tokyo",
            "Singapore",
            "Hong Kong",
            "London",
            "Paris",
            "Bangkok",
            "Dubai",
            "Rome",
            "Macau",
            "Istanbul",
            "Kuala Lumpur",
            "Delhi",
            "Antalya",
            "Ho Chi Minh City",
        ]
        
        let city = names.map {
            return City(city_id: randomId(), city_name: $0)
        }
        
        return city
    }
}
