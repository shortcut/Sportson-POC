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
        if !store.isBikeRegistered || !store.didRegisterBike {
            VStack {
                Spacer()
                Image("myBike")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.size.width,
                   height: UIScreen.main.bounds.size.height)
            .background(Color.mainBg.edgesIgnoringSafeArea(.all))
            .ignoresSafeArea(.all)
        } else {
            emptyStateView
                .frame(width: UIScreen.main.bounds.size.width,
                       height: UIScreen.main.bounds.size.height)
                .background(Color.mainBg.edgesIgnoringSafeArea(.all))
                .ignoresSafeArea(.all)
        }
    }

    var emptyStateView: some View {
        VStack {
            Spacer()
            Button("Open camera") {
                self.showCamera.toggle()
            }
            .fullScreenCover(isPresented: self.$showCamera) {
                accessCameraView(selectedImage: self.$selectedImage)
                    .ignoresSafeArea(.all)
            }
            Spacer()
        }
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
    }
}

#Preview {
    MyBicycleView()
}
