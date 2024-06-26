//
//  ActivityView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/26.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
   
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> some UIViewController {
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return activityController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
    
}
