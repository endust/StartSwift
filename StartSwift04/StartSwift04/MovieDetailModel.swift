//
//  MovieDetailModel.swift
//  StartSwift04
//
//  Created by Winn on 2018/6/18.
//  Copyright © 2018年 Winn. All rights reserved.
//

//import UIKit


//// 中间`架构`类型
//struct GroceryStoreService: Decodable {
//    let name: String
//    let aisles: [Aisle]
//
//    struct Aisle: Decodable {
//        let name: String
//        let shelves: [Shelf]
//
//        struct Shelf: Decodable {
//            let name: String
//            let product: Product
//        }
//    }
//}

//// 扩展接口，实现数据解析
//extension GroceryStore {
//    init(from service: GroceryStoreService) {
//        name = service.name
//        products = []
//
//        for aisle in service.aisles {
//            for shelf in aisle.shelves{
//                products.append(shelf.product)
//            }
//        }
//    }
//}


