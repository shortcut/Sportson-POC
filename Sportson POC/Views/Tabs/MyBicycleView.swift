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
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 0) {
            if store.isBikeRegistered || store.didRegisterBike {
                myBikeView
            } else {
                emptyStateView
            }
        }
        .modifier(FakeNavBarModifier(title: "MY BIKE"))
    }

    var emptyStateView: some View {
        VStack {
            Button(action:  {
                self.showCamera.toggle()
            },label: {
                HStack {
                    Image(systemName: "bicycle")
                    Text("REGISTER BIKE")
                }
            })
            .font(.title2)
            .fontWeight(.semibold)
            .buttonStyle(CapsuleButtonStyle())
            .fullScreenCover(isPresented: self.$showCamera) {
                accessCameraView(selectedImage: self.$selectedImage)
                    .ignoresSafeArea(.all)
            }
        }
        .modifier(BackgroundModifier())
    }

    var myBikeView: some View {
        VStack {
            Image("myBike")
                .resizable()
                .scaledToFit()
        }
        .modifier(BackgroundModifier())
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView

    init(picker: accessCameraView) {
        self.picker = picker
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
        NotificationCenter.default.post(name: .didRegisterBike, object: nil)
    }
}

#Preview {
    MyBicycleView()
        .environmentObject(Store())
}
