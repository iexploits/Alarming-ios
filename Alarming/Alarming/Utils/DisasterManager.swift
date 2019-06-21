//
//  DisasterManager.swift
//  Alarming
//
//  Created by Jae Heo on 20/06/2019.
//  Copyright © 2019 iExploits. All rights reserved.
//

import Foundation

class DisasterManager {
    
    static let sharedInstance = DisasterManager()
    
    private var disaster_list: Array<DisasterInfo> = []
    
    init()
    {
        
    }
    
    func ADD_info(dInfo: DisasterInfo)
    {
        disaster_list.append(dInfo)
    }
    
    func GET_info(pos: Int) -> DisasterInfo
    {
        return disaster_list[pos]
    }
    
    func GET_size() -> Int
    {
        return disaster_list.count
    }
    
    
}
