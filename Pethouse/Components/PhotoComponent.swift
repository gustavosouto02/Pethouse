//
//  PhotoComponent.swift
//  Pethouse
//
//  Created by Thiago de Jesus on 03/07/25.
//

import SwiftUI

struct PhotoComponent: View {
    var body: some View {
        Circle()
            //.foregroundStyle(Color(uiColor: UIColor.systemGroupedBackground))
            .frame(width: 150, height: 150)
            .foregroundStyle(.white)
            .overlay(content: {
              Image(systemName: "photo.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .foregroundColor(Color.accentColor)
            })
    }
}

#Preview {
    PhotoComponent()
}
