//
//  SNImage.swift
//  Snippet
//
//  Created by Seb Vidal on 03/07/2022.
//

import Cocoa
import Kingfisher

class SNImage {
    var path: [URL]
    var thumbnail: String
    var dynamic: Bool = false
    var preset: Int?
    
    private init(path: [URL?], thumbnail: String, preset: Int? = nil) {
        self.path = path.compactMap { $0 }
        self.thumbnail = thumbnail
        self.dynamic = path.count > 1
        self.preset = preset
    }
    
    convenience init(path: [URL?], thumbnail: String) {
        self.init(path: path, thumbnail: thumbnail, preset: nil)
    }
}

extension SNImage {
    static let presets = [
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FSnowLeopard.jpg?alt=media&token=5318e0ce-7c01-48fe-ab34-fa58dad377f3")
            ],
            thumbnail: "SnowLeopard-Thumbnail",
            preset: 0
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FLion.jpg?alt=media&token=4cbe826d-6d71-4926-8229-f2308dd90ef0")
            ],
            thumbnail: "Lion-Thumbnail",
            preset: 1
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FMavericks.jpg?alt=media&token=3c419aa0-a337-4a5e-969f-af3753a9c271")
            ],
            thumbnail: "Mavericks-Thumbnail",
            preset: 2
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FYosemite.jpg?alt=media&token=9453219f-d6ab-4b21-bca8-baadf004605a")
            ],
            thumbnail: "Yosemite-Thumbnail",
            preset: 3
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FElCapitan.jpg?alt=media&token=c53a839f-a44d-44c5-8fc2-2e1afe4d756c")
            ],
            thumbnail: "ElCapitan-Thumbnail",
            preset: 4
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FSierra.jpg?alt=media&token=2c18ca41-917a-4c15-a9f2-67bc1e580670")
            ],
            thumbnail: "Sierra-Thumbnail",
            preset: 5
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FHighSierra.jpg?alt=media&token=28086e92-a49a-484e-a108-8a0ea0d3343b")
            ],
            thumbnail: "HighSierra-Thumbnail",
            preset: 6
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FMojave-Light.jpg?alt=media&token=2aea9624-4be8-494a-884a-15ba7fb6a321"),
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FMojave-Dark.jpg?alt=media&token=2cfbd432-2a03-4aee-be19-588f8338ad26")
            ],
            thumbnail: "Mojave-Thumbnail",
            preset: 7
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FCatalina-Light.jpg?alt=media&token=fc3d438e-d9c7-41a5-a675-0b8c60937c04"),
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FCatalina-Dark.jpg?alt=media&token=b2af027d-6c15-4660-a82e-928f446a915e")
            ],
            thumbnail: "Catalina-Thumbnail",
            preset: 8
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FBigSur-1-Light.jpg?alt=media&token=3453f08a-1f6a-4a8d-940a-4b3994b6bdc6"),
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FBigSur-1-Dark.jpg?alt=media&token=5f2f0f9f-9f9b-4cb1-8a32-f0afd044aace")
            ],
            thumbnail: "BigSur-1-Thumbnail",
            preset: 9
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FBigSur-2-Light.jpg?alt=media&token=1db6925d-607e-46d8-afc6-d24851a02d40"),
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FBigSur-2-Dark.jpg?alt=media&token=9832d021-285d-4024-a026-9a13411b0380")
            ],
            thumbnail: "BigSur-2-Thumbnail",
            preset: 10
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FMonterey-Light.jpg?alt=media&token=9f63f754-94e2-4375-bd09-f7d108365b13"),
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FMonterey-Dark.jpg?alt=media&token=89f2c58b-106d-4800-83d6-ea54e720c1d6")
            ],
            thumbnail: "Monterey-Thumbnail",
            preset: 11
        ),
        SNImage(
            path: [
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FVentura-Light.png?alt=media&token=ae910aaa-8d1e-4e8f-9220-47a3d7fd4056"),
                URL(string: "https://firebasestorage.googleapis.com/v0/b/snippet-4371d.appspot.com/o/Wallpapers%2FVentura-Dark.png?alt=media&token=bcaa5a52-83fe-42db-a220-0849f3961d39")
            ],
            thumbnail: "Ventura-Thumbnail",
            preset: 12
        )
    ]
}
