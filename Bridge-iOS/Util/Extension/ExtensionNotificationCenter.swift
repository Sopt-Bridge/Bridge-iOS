//
//  ExtensionNotificationCenter.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 10..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let AVPlayerViewControllerDismissingNotification = Notification.Name.init("AVPlayerViewControllerDismissingNotification")
    static let HomeCategoryChanged = Notification.Name.init("HomeCategoryChanged")
    static let HomeReloadAllCollectionView = Notification.Name.init("HomeReloadAllCollectionView")
    static let ContentViewReloadAllTableView = Notification.Name.init("ContentViewReloadAllTableView")
    static let RefreshNavigationItem = Notification.Name.init("RefreshNavigationItem")
    static let ReplayCommentReloadAllTableView = Notification.Name.init("ReplayCommentReloadAllTableView")
    static let ContentViewInit = Notification.Name.init("ContentViewInit")
    static let RequestCommentViewRefresh = Notification.Name.init("RequestCommentViewRefresh")
}
