//
//  MyBicycleView.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 16. 4. 2024..
//

import SwiftUI
import PhotosUI
import Core

struct MyBicycleView: View {
    @EnvironmentObject var store: Store
    @State private var showCamera = false
    @State private var detectedQRCode: String? = nil

    var body: some View {
        VStack() {
            if store.isBikeRegistered || store.didRegisterBike {
                    bikeDetailView()
                        .padding(.horizontal, 16)
                    Button(action:  { },label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.gray)
                            Text("Ändra innehåll")
                                .font(.emRegular(size: 14))
                                .foregroundColor(.gray)
                        }
                    })
                    .frame(height: 50)
                    .buttonStyle(CapsuleButtonClearStyle())
                Spacer()
            } else {
                emptyStateView
            }
        }
        .modifier(BackgroundModifier())
        .modifier(FakeNavBarModifier(icon: "b", title: "Mina Cyklar"))
    }

    var emptyStateView: some View {
        VStack {
            Button(action:  {
                self.showCamera.toggle()
            },label: {
                HStack {
                    Text("b")
                        .font(.sportson(size: 32))
                    Text("Lägg till ny cykel")
                        .font(.emRegular(size: 22))
                }
                .frame(width: UIScreen.main.bounds.size.width * 0.8)
            })
            .buttonStyle(CapsuleButtonYellowStyle())
            .fullScreenCover(isPresented: self.$showCamera) {
                QRCodeScannerView(detectedQRCode: $detectedQRCode)
                    .ignoresSafeArea(.all)
            }
        }
    }

    @ViewBuilder
    func bikeDetailView() -> some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Cresent".uppercased())
                        .font(.emSemiBold(size: 14))
                    Spacer()
                    Text("Ramnummer: \(store.registeredSerialNumber)")
                        .font(.emRegular(size: 14))
                        .foregroundStyle(.gray)
                }
                .padding(.top, 8)
                .foregroundColor(.black)

                Text("Kids Fantastic BMX")
                    .font(.emBold(size: 26))
            }
            Image("myBike")
                .resizable()
                .scaledToFit()

            myBikeSelection("Produktinformation")
            myBikeSelection("Teknisk specifikation")
            myBikeSelection("Tillbehör")
                .onTapGesture {
                    store.shouldPresentBikeModal = true
                }
            myBikeSelection("Boka cykelservice")
                .onTapGesture {
                    store.shouldPresentService = true
                }
        }
        .padding(.horizontal, 16)
        .modifier(RoundedCardModifier())
        .padding(.top, 16)
    }

    @ViewBuilder
    func myBikeSelection(_ text: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(text)
                    .font(.emRegular(size: 16))
                Spacer()
                ZStack {
                    Circle().fill(Color.spYellow)
                        .frame(width: 30, height: 30)
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.vertical, 16)
            DottedLine()
                .stroke(style: .init(dash: [2]))
                .foregroundStyle(.gray.opacity(0.5))
                            .frame(height: 1)
        }
        .frame(height: 60)
    }
}

struct QRCodeScannerView: UIViewControllerRepresentable {
    @Binding var detectedQRCode: String?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            fatalError("No video camera available")
        }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            fatalError("Unable to obtain video input")
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            fatalError("Unable to add video input")
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]  // QR Code
        } else {
            fatalError("Unable to add metadata output")
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRCodeScannerView

        init(_ parent: QRCodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                if metadataObject.type == .qr, let stringValue = metadataObject.stringValue {
                    parent.detectedQRCode = stringValue
                    NotificationCenter.default.post(name: .didRegisterBike, object: nil)
                }
            }
        }
    }
}

#Preview {
    MyBicycleView()
        .environmentObject(Store())
}
