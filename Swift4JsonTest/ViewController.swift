//
//  ViewController.swift
//  Swift4JsonTest
//
//  Created by VAndrJ on 6/19/17.
//  Copyright © 2017 VAndrJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelResult: UILabel!
    var encodedJson: Data?

    @IBAction func encodeTouchUp(_ sender: UIButton) {
        initStructAndEncodeJson()
    }

    @IBAction func decodeTouchUp(_ sender: UIButton) {
        decodeJson()
    }

    @IBAction func fetchTouchUp(_ sender: UIButton) {
        fetchAndDecodeJson()
    }

    func initStructAndEncodeJson() {
        let event = Event(name: "JSON", description: "JSON encoding in Swift 4")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let encodedJson = try? encoder.encode(event) else {
            printErrorMessage(with: #line)
            return
        }
        self.encodedJson = encodedJson
        labelResult.text = String(data: encodedJson, encoding: .ascii)
    }

    func decodeJson() {
        guard let event = Event.decode(with: encodedJson) else {
            printErrorMessage(with: #line)
            return
        }
        labelResult.text = """
        Name: \(event.name)
        Description: \(event.description)
        """
    }

    func fetchAndDecodeJson() {
        let dataTask = URLSession.shared.dataTask(with: Event.endpointUrl) { [weak self] (data, response, _) in
            guard let event = Event.decode(with: data) else {
                self?.printErrorMessage(with: #line)
                return
            }
            DispatchQueue.main.async {
                self?.labelResult.text = """
                Name: \(event.name)
                Description: \(event.description)
                """
            }
        }
        dataTask.resume()
    }

    func printErrorMessage(with line: Int) {
        print("""
            Oops. Handle error in
            File: \(#file)
            Above the line: \(line)
            """)
    }
}


