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
        VStack() {
            if store.isBikeRegistered || store.didRegisterBike {
                    bikeDetailView()
                        .padding(.horizontal, 16)
                        .padding(.top, 70)
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
            .padding(.top, 140)
            .buttonStyle(CapsuleButtonYellowStyle())
            .fullScreenCover(isPresented: self.$showCamera) {
                accessCameraView(selectedImage: self.$selectedImage)
                    .ignoresSafeArea(.all)
            }
        }
    }

    @ViewBuilder
    func bikeDetailView() -> some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Cresent".uppercased())
                        .font(.emSemiBold(size: 14))
                    Text("Kids Fantastic BMX")
                        .font(.emBold(size: 26))
                }
                .foregroundColor(.black)
                Spacer()
                Text("Ramnummer: \(store.registeredSerialNumber)")
                    .font(.emRegular(size: 14))
                    .foregroundStyle(.gray)
            }
            .padding(.top, 8)
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
        }
        .padding(.horizontal, 16)
        .modifier(RoundedCardModifier())
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
