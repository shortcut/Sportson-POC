//
//  LoginView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core
import AVKit
import AVFoundation

struct LoginView: View {
    @InjectObject var store: Store

    var body: some View {
        GeometryReader{ geo in
            ZStack {
                PlayerView()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height+100)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.2))
                    .blur(radius: 1)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    Image("sportson_logo_big")
                    Spacer()
                    Button(action:  {
                        store.isUserLogged = true
                        store.userDidLogin = true
                    },label: {
                        Text("LOGIN")
                            .frame(width: UIScreen.main.bounds.size.width * 0.7)
                    })
                    .font(.title2)
                    .fontWeight(.semibold)
                    .buttonStyle(CapsuleButtonStyle())
                    .padding(.bottom, 120)
                }
                .frame(width: UIScreen.main.bounds.size.width)
            }
        }

    }
}

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: UIViewRepresentableContext<PlayerView>) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Load the resource -> h
        let fileUrl = Bundle.main.url(forResource: "video", withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        // Start the movie
        player.play()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

#Preview {
    LoginView()
}
