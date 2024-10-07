//
//  ApiStateOverlayView.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import SwiftUI

struct ApiStateOverlayView: View {
    let title: String
       let systemImage: String
       let descriptionText: String
       let buttonTitle: String?
       let buttonAction: (() -> Void)?
    
    init(title: String, systemImage: String, descriptionText: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        self.title = title
        self.systemImage = systemImage
        self.descriptionText = descriptionText
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
       
       var body: some View {
           ContentUnavailableView {
               Label(title, systemImage: systemImage)
           } description: {
               Text(descriptionText)
           } actions: {
               if let buttonTitle = buttonTitle, let buttonAction = buttonAction {
                   Button(buttonTitle) {
                       buttonAction()
                   }
               }
           }
       }
}

