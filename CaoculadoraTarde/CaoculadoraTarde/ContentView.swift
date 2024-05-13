//
//  ContentView.swift
//  CaoculadoraTarde
//
//  Created by Francisco Miranda Soares on 07/05/24.
//

import SwiftUI

struct ContentView: View {

    @State var years: Int?
    @State var months: Int?
    @State var result: Int?
    @State var porteSelecionado: Porte = .pequeno

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20.0) {
                    Text("Qual a idade do seu cão?")
                        .font(.header5)
                        .padding(.top, 24)
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("Anos")
                            .font(.body1)
                        TextField(
                            "Quantos anos completos seu cão tem.",
                            value: $years,
                            format: .number
                        )
                    }
                    VStack(alignment: .leading, spacing: 8.0) {

                        Text("Meses")
                            .font(.body1)
                        TextField(
                            "E quantos meses além disso ele tem.",
                            value: $months,
                            format: .number
                        )
                    }
                    VStack(alignment: .leading, spacing: 8.0) {

                        Text("Porte")
                            .font(.body1)

                        Picker("Porte", selection: $porteSelecionado) {
                            ForEach(Porte.allCases, id: \.self) { porte in
                                Text(porte.rawValue)
                                    .tag(porte)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Divider()
                        .background(.purple)
                    Spacer()

                    if let result {
                        Text("Seu cachorro tem, em idade humana...")
                            .font(.body1)
                            .frame(maxWidth: .infinity)
                        Text("\(result) anos")
                            .font(.display)
                            .frame(maxWidth: .infinity)
                    } else {
                        Image(ImageResource.clarinha)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: .infinity)
                            .shadow(radius: 20)
                    }

                    Spacer()
                    Button(action: processYears, label: {
                        ZStack {
                            Color.indigo600
                            Text("Cãocular")
                                .foregroundStyle(.white)
                                .font(.body1)
                        }
                    })
                    .cornerRadius(10)
                    .frame(height: 50)
                }
                .containerRelativeFrame(.vertical)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .bold()
                .fontDesign(.rounded)
                .padding()
                .navigationTitle("Cãoculadora")
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.indigo600, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar, .tabBar)
            }
            .scrollDismissesKeyboard(.immediately)
        }
    }

    func processYears() {
        guard
            let years,
            let months
        else {
            print("preencha o campo de entrada")
            return
        }
        guard years > 0 || months > 0 else {
            print("algum campo tem que ter valor maior que zero")
            return
        }

        result = porteSelecionado.conversaoDeIdade(
            anos: years,
            meses: months
        )

    }
}

#Preview {
    ContentView()
}
