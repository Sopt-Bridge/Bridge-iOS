//
//  ExtensionAVPlayerViewController.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 10..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import AVKit

extension AVPlayerViewController {
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .AVPlayerViewControllerDismissingNotification, object: nil)
    }
}
