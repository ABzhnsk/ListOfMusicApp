//
//  DateFormatter+.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 17.08.2022.
//

import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }()
}
