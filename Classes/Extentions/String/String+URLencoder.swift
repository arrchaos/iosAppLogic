//
//  String+URLencoder.swift
//  WidgetX
//
//  Created by Илья on 27.03.2023.
//

import Foundation

extension String
{
    public func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    public func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
