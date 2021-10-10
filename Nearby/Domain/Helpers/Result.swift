//
//  AppResult.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation

enum AppResult<T> {
    case success(data: T)
    case failure(errorMessage: String, statusCode: Int = 500)
}

enum PaginationResult<T> {
    case success(data: T, totalCount: Int)
    case failure(errorMessage: String, statusCode: Int = 500)
}


