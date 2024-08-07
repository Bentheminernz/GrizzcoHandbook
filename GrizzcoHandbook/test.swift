import SwiftUI

struct testView: View {
    @State private var simulatorName: String = ""
    @State private var dataNetwork: Int = 0
    @State private var wifiMode: Int = 0
    @State private var wifiBars: Double = 0
    @State private var cellularMode: Int = 0
    @State private var cellularBars: Double = 0
    @State private var operatorName: String = ""
    @State private var batteryState: Int = 0
    @State private var batteryLevel: Double = 0

    var body: some View {
        VStack {
            Form {
                TextField("Simulator Name", text: $simulatorName)
                
                Picker("Data Network", selection: $dataNetwork) {
                    Text("hide").tag(0)
                    Text("wifi").tag(1)
                    Text("3g").tag(2)
                    Text("4g").tag(3)
                    Text("lte").tag(4)
                    Text("lte-a").tag(5)
                    Text("lte+").tag(6)
                    Text("5g").tag(7)
                    Text("5g+").tag(8)
                    Text("5g-uwb").tag(9)
                    Text("5g-uc").tag(10)
                }
                
                Picker("Wifi Mode", selection: $wifiMode) {
                    Text("searching").tag(0)
                    Text("failed").tag(1)
                    Text("active").tag(2)
                }
                
                HStack {
                    Text("Wifi Bars:")
                    Slider(value: $wifiBars, in: 0...3, step: 1)
                        .frame(maxWidth: 150)  // Adjust slider width if needed
                    Text("\(Int(wifiBars))")
                        .frame(width: 40, alignment: .leading)
                }
                .padding(.vertical, 8)
                
                Picker("Cellular Mode", selection: $cellularMode) {
                    Text("notSupported").tag(0)
                    Text("searching").tag(1)
                    Text("failed").tag(2)
                    Text("active").tag(3)
                }
                
                HStack {
                    Text("Cellular Bars:")
                    Slider(value: $cellularBars, in: 0...4, step: 1)
                        .frame(maxWidth: 150)  // Adjust slider width if needed
                    Text("\(Int(cellularBars))")
                        .frame(width: 40, alignment: .leading)
                }
                .padding(.vertical, 8)
                
                TextField("Operator Name", text: $operatorName)
                
                Picker("Battery State", selection: $batteryState) {
                    Text("charging").tag(0)
                    Text("charged").tag(1)
                    Text("discharging").tag(2)
                }
                
                HStack {
                    Text("Battery Level:")
                    Slider(value: $batteryLevel, in: 0...100)
                        .frame(maxWidth: 150)  // Adjust slider width if needed
                    TextField("", value: $batteryLevel, formatter: NumberFormatter())
                        .frame(width: 50)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("%")
                        .frame(width: 20, alignment: .leading)
                }
                .padding(.vertical, 8)
            }
            .padding()
        }
    }
}

#Preview {
    testView()
}
