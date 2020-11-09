//
//  EKWindow.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class EKWindow: UIWindow {
    
    var isAbleToReceiveTouches = false
    
    init(with rootVC: UIViewController) {
        if #available(iOS 13.0, *) {
            // TODO: Patched to support SwiftUI out of the box but should require attendance
            // UIApplication에서 connectedScenes를 찾지 못하는 크래시가 발생하는데 정확한 원인 파악 불가, 실행하기 전에 무조건 responds 여부 확인 필요
            if UIApplication.shared.responds(to: #selector(getter: UIApplication.connectedScenes)), let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene } ) as? UIWindowScene {
                super.init(windowScene: scene)
            } else {
                super.init(frame: UIScreen.main.bounds)
            }
        } else {
            super.init(frame: UIScreen.main.bounds)
        }
        backgroundColor = .clear
        rootViewController = rootVC
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isAbleToReceiveTouches {
            return super.hitTest(point, with: event)
        }
        
        guard let rootVC = EKWindowProvider.shared.rootVC else {
            return nil
        }
        
        if let view = rootVC.view.hitTest(point, with: event) {
            return view
        }
        
        return nil
    }
}
