//
//  Events.swift
//  Swift4JsonTest
//
//  Created by VAndrJ on 6/19/17.
//  Copyright © 2017 VAndrJ. All rights reserved.
//

import Foundation

struct Event: Codable {
    var name: String
    var description: String

    static func decode(with data: Data?) -> Event? {
        guard let jsonData = data else {
            return nil
        }
        return try? JSONDecoder().decode(Event.self, from: jsonData)
    }

    static var endpointUrl: URL {
        return URL(string: "http://echo.jsontest.com/name/DummyEvent/description/DummyDescription")!
    }
}
