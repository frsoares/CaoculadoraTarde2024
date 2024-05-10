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
    let portes = ["Pequeno", "Médio", "Grande"]
    @State var porte: String = "Pequeno"

    var body: some View {
        VStack(alignment: .leading) {
            Text("Qual a idade do seu cão?")
                .font(.system(size: 24))
            Text("Anos")
            TextField(
                "Quantos anos completos seu cão tem.",
                value: $years,
                format: .number
            )
            Text("Meses")
            TextField(
                "E quantos meses além disso ele tem.",
                value: $months,
                format: .number
            )
            Text("Porte")

            Picker("Porte", selection: $porte) {
                ForEach(portes, id: \.self) { porte in
                    Text(porte)
                        .tag(porte)
                }
            }
            .pickerStyle(.segmented)

            Divider()
                .background(.purple)
            Spacer()

            if let result {
                Text("Seu cachorro tem, em idade humana...")
                Text("\(result) anos")
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
                    Color.purple
                    Text("Cãocular")
                        .foregroundStyle(.white)
                }
            })
            .cornerRadius(10)
            .frame(height: 50)
        }
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
        .bold()
        .fontDesign(.rounded)
        .padding()
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

        result = years * 7 + months*7/12

    }
}

#Preview {
    ContentView()
}
