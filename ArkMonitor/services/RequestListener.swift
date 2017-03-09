//
//  RequestListner.swift
//  ArkMonitor
//
//  Created by Victor Lins on 23/01/17.
//  Copyright © 2017 vrlc92. All rights reserved.
//

protocol RequestListener: class {
    func onFailure(e: Error)
    func onResponse(object: Any)
}
