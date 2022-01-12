//
//  PicsumModel.swift
//  Picsum App
//
//  Created by Matthew Gray on 1/12/22.
//

import Foundation

struct PicsumModel: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
