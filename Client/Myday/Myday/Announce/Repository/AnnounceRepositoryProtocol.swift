//
//  AnnounceRepositoryProtocol.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 21/9/2565 BE.
//

import Foundation

//MARK: Repository
protocol AnnounceRepositoryProtocol {
    func fetchAnnounceNisitList(completion: @escaping (_ data: AnnounceNisitEntity?, _ isStatusApi: Bool) -> Void)
    func fetchAnnounceAdminList(completion: @escaping (_ data: AnnounceAdminEntity?, _ isStatusApi: Bool) -> Void)
    
}

