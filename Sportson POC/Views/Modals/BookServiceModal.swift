//
//  BookServiceModal.swift
//  Sportson POC
//
//  Created by Marco-Shortcut on 8. 5. 2024..
//

import SwiftUI
import ShortcutFoundation
import Core

struct BookServiceModal: View {
    @InjectObject var store: Store
    @InjectObject var vm: BookingViewModel

    @FocusState private var focusItem: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            viewFor(index: vm.selectedPageIndex)
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    ForEach((0...5), id: \.self) { index in
                        pageIndicatorElement(index)
                    }
                }
                Rectangle()
                    .fill(.clear)
                    .frame(height: 100)
            }
        }
        .modifier(ModalBackgroundModifier())
        .modifier(FakeNavBarModifier(icon: "", title: "Service", action: { backAction() }))
    }

    private func backAction() {
        guard vm.selectedPageIndex > 0 else {
            store.shouldPresentService = false
            return
        }
        vm.selectedPageIndex -= 1
    }

    private func continueAction() {
        guard vm.selectedPageIndex < 5 else {
            store.shouldPresentService = false
            return
        }
        vm.selectedPageIndex += 1
    }

    @ViewBuilder
    func pageIndicatorElement(_ index: Int) -> some View {
        Circle()
            .fill(vm.selectedPageIndex == index ? Color.spYellow : .gray.opacity(0.3))
            .frame(width: 18, height: 18)
    }

    @ViewBuilder
    func viewFor(index: Int) -> some View {
        switch index {
        case 0:
            butikView()
        case 1:
            dateView()
        case 2:
            contactView()
        case 3:
            verificationView()
        case 4:
            serviceSelectionView()
        case 5:
            confirmationView()
        default:
            butikView()
        }
    }

    @ViewBuilder
    func butikView() -> some View {
        VStack {
            VStack {
                HStack {
                    Text("Cykelservice")
                        .font(.emSemiBold(size: 26))
                    Spacer()
                }
                .padding([.horizontal, .top], 16)
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("Butik")
                            .font(.emSemiBold(size: 16))
                        Spacer()
                    }

                    ZStack {
                        Rectangle()
                            .fill(Color.mainBg)
                            .frame(width: UIScreen.main.bounds.size.width - 64,
                                   height: 52)
                            .border(Color.spYellow, width: 1)

                        Picker("Stad", selection: $vm.selectedCity) {
                            ForEach(BookingViewModel.City.allCases) { city in
                                Text(city.description())
                                    .font(.emSemiBold(size: 16))
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 16)
                    }
                    continueButton("Välj stad", enabled: vm.hasSelectedCity)
                }
                .padding(16)
            }
            .modifier(RoundedCardModifier())
            .padding([.horizontal, .top], 16)
            Spacer()
        }
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func dateView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Datum")
                            .font(.emBold(size: 26))
                        Spacer()
                    }
                    .padding([.horizontal, .top], 16)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Välj ett datum som passar dig nedan, överstrukna datum är ej bokningsbara.")
                            .font(.emRegular(size: 16))
                        Text("Lämna cykeln dagen före, alternativt senast kl 11 samma dag.")
                            .font(.emRegular(size: 16))
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 16)

                    ForEach(vm.availableDates) { date in
                        dateSelection(date.date, isAvailable: date.isAvailable)
                            .onTapGesture {
                                vm.selectedDate = date.date
                            }
                    }
                    .padding(.horizontal, 16)

                    continueButton("Välj datum", enabled: vm.hasSelectedDate)
                        .padding(.bottom, 16)
                }

            }
            .modifier(RoundedCardModifier())
            .padding(.top, 16)
            Spacer()
        }
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    func contactView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Kontaktuppgifgter")
                            .font(.emBold(size: 26))
                        Spacer()
                    }
                    .padding([.horizontal, .top], 16)

                    Text("Ange ditt telefonnummer nedan och tryck på “Skicka koden”. Du kommer sedan att få ett SMS skickat till dig med en kod på fem siffror.")
                        .font(.emRegular(size: 16))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 8)
                        .padding(.horizontal, 16)

                    HStack {
                        Text("Telefonnummer")
                            .font(.emSemiBold(size: 16))
                            .padding(.top, 8)
                            .padding(.horizontal, 16)
                        Spacer()
                    }

                    ZStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.mainBg)
                                .frame(width: .infinity, height: 56)
                            Rectangle()
                                .fill(Color.spYellow)
                                .frame(width: .infinity, height: 2)
                        }
                        HStack {
                            Text("+46")
                                .font(.emSemiBold(size: 16))
                            TextField(text: $vm.selectedPhoneNumber,
                                      label: {
                                Text("")
                            })
                            .onSubmit {
                                focusItem = false
                            }
                            .keyboardType(.numberPad)
                            .focused($focusItem)
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.horizontal, 16)

                    HStack(alignment: .top) {
                        ZStack {
                            Rectangle()
                                .fill(Color.mainBg)
                                .frame(width: 32,
                                       height: 32)
                                .border(Color.spYellow, width: 1)
                            if vm.hasAcceptedTerms {
                                Image(systemName: "checkmark")
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .onTapGesture {
                            vm.hasAcceptedTerms.toggle()
                        }

                        Text("Jag har läst och förstått Bike Action i Sverige ABs (Sportson Sverige) hantering av mina personuppgifter i enlighet med integritetspolicyn.")
                            .font(.emRegular(size: 16))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 16)

                    continueButton("Skicka koden", enabled: vm.hasGivenPhone)
                        .padding(.bottom, 16)
                }

            }
            .modifier(RoundedCardModifier())
            .padding(.top, 16)
            Spacer()
        }
        .padding(.horizontal, 16)
        .onTapGesture {
            focusItem = false
        }
    }

    @ViewBuilder
    func verificationView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Verifiering")
                            .font(.emBold(size: 26))
                        Spacer()
                    }
                    .padding([.horizontal, .top], 16)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Koden anger du in i fältet nedan och fortsätter med att trycka på “Verifiera”.")
                            .font(.emRegular(size: 16))
                        Text("Inte fått någon kod? Tryck “Tillbaka” och kolla så att du angett rätt telefonnummer.")
                            .font(.emRegular(size: 16))
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 16)

                    HStack {
                        Text("Kod")
                            .font(.emSemiBold(size: 16))
                            .padding(.top, 8)
                            .padding(.horizontal, 16)
                        Spacer()
                    }

                    ZStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.mainBg)
                                .frame(width: .infinity, height: 56)
                            Rectangle()
                                .fill(Color.spYellow)
                                .frame(width: .infinity, height: 2)
                        }

                        TextField(text: $vm.selectedCode,
                                  label: {
                            Text("")
                        })
                        .onSubmit {
                            focusItem = false
                        }
                        .keyboardType(.numberPad)
                        .focused($focusItem)
                        .padding(.horizontal, 16)

                    }
                    .padding(.horizontal, 16)

                    continueButton("Verifiera", enabled: vm.hasGivenCode)
                        .padding(.bottom, 16)
                }

            }
            .modifier(RoundedCardModifier())
            .padding(.top, 16)
            Spacer()
        }
        .padding(.horizontal, 16)
        .onTapGesture {
            focusItem = false
        }
    }

    @ViewBuilder
    func serviceSelectionView() -> some View {
        VStack {
            VStack {
                HStack {
                    Text("Välj Service")
                        .font(.emSemiBold(size: 26))
                    Spacer()
                }
                .padding([.horizontal, .top], 16)

                Text("Berätta lite om vilken typ av service du vill utföra.")
                    .font(.emRegular(size: 16))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)

                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text("Service")
                            .font(.emSemiBold(size: 16))
                        Spacer()
                    }

                    ZStack {
                        Rectangle()
                            .fill(Color.mainBg)
                            .frame(width: UIScreen.main.bounds.size.width - 64,
                                   height: 52)
                            .border(Color.spYellow, width: 1)

                        Picker("Service", selection: $vm.selectedService) {
                            ForEach(BookingViewModel.Service.allCases) { service in
                                Text(service.description())
                                    .font(.emSemiBold(size: 16))
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 16)
                    }

                    HStack {
                        Text("Mer information")
                            .font(.emSemiBold(size: 16))
                        Spacer()
                    }

                    ZStack(alignment: .top) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.mainBg)
                                .frame(width: UIScreen.main.bounds.size.width - 64,
                                       height: 250)
                                .border(Color.spYellow, width: 1)
                        }

                        TextField(text: $vm.extraInfo,
                                  label: {
                            Text("")
                        })
                        .onSubmit {
                            focusItem = false
                        }
                        .focused($focusItem)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)

                    }

                    continueButton("Skicka", enabled: vm.hasSelectedService)
                }
                .padding(16)
            }
            .modifier(RoundedCardModifier())
            .padding([.horizontal, .top], 16)
            Spacer()
        }
        .padding(.horizontal, 16)
        .onTapGesture {
            focusItem = false
        }
    }

    @ViewBuilder
    func confirmationView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Bekräftelse")
                            .font(.emBold(size: 26))
                        Spacer()
                    }
                    .padding([.horizontal, .top], 16)

                    Text("Vi har bokat in dig \(vm.selectedDate). Lämna cykeln dagen före, alternativt senast kl 11 samma dag.")
                        .font(.emRegular(size: 16))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 8)
                        .padding(.horizontal, 16)

                    HStack {
                        Text("Påmminelse")
                            .font(.emSemiBold(size: 16))
                            .padding(.top, 8)
                            .padding(.horizontal, 16)
                        Spacer()
                    }

                    VStack {
                        HStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.mainBg)
                                    .frame(width: 32,
                                           height: 32)
                                    .border(Color.spYellow, width: 1)
                                if vm.hasChosenPush {
                                    Image(systemName: "checkmark")
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .onTapGesture {
                                vm.hasChosenPush.toggle()
                            }

                            Text("Pushnotifikation")
                                .font(.emRegular(size: 16))

                            Spacer()
                        }

                        HStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.mainBg)
                                    .frame(width: 32,
                                           height: 32)
                                    .border(Color.spYellow, width: 1)
                                if vm.hasChosenSMS {
                                    Image(systemName: "checkmark")
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .onTapGesture {
                                vm.hasChosenSMS.toggle()
                            }

                            Text("SMS")
                                .font(.emRegular(size: 16))

                            Spacer()
                        }

                        HStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.mainBg)
                                    .frame(width: 32,
                                           height: 32)
                                    .border(Color.spYellow, width: 1)
                                if vm.hasChosenEmail {
                                    Image(systemName: "checkmark")
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .onTapGesture {
                                vm.hasChosenEmail.toggle()
                            }

                            Text("E-post")
                                .font(.emRegular(size: 16))

                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)

                    continueButton("Stäng", enabled: true)
                        .padding(.bottom, 16)
                }

            }
            .modifier(RoundedCardModifier())
            .padding(.top, 16)
            Spacer()
        }
        .padding(.horizontal, 16)
        .onTapGesture {
            focusItem = false
        }
    }

    @ViewBuilder
    private func dateSelection(_ text: String, isAvailable: Bool) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(text)
                    .font(.emRegular(size: 16))
                    .strikethrough(!isAvailable)
                Spacer()
                if isAvailable {
                    ZStack(alignment: .center) {
                        Circle().fill(Color.spYellow)
                            .frame(width: 30, height: 30)
                        if text != vm.selectedDate {
                            Circle().fill(Color.white)
                                .frame(width: 25, height: 25)
                        }
                    }
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

    @ViewBuilder
    private func continueButton(_ text: String, enabled: Bool) -> some View {
        Button(action:  {
            continueAction()
        },label: {
            Text(text)
                .font(.emRegular(size: 22))
                .frame(width: UIScreen.main.bounds.size.width - 100)
        })
        .buttonStyle(CapsuleButtonYellowStyle(enabled: enabled)
        )
        .disabled(!enabled)
        .padding(.top, 16)
    }

    private func isBooked() -> Bool {
        store.isBooked && store.serviceDate != ""
    }
}

#Preview {
    BookServiceModal()
}
