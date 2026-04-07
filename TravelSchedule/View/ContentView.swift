
import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchStation()
        }
    }
}

#Preview {
    ContentView()
}

func testFetchStation() {
    QueryExamples.getNearestStations()
    QueryExamples.getCarrierInfo()
    QueryExamples.getCopyright()
    QueryExamples.getNearestCity()
    QueryExamples.getStationSchedule()
    QueryExamples.getScheduleBetweenStations()
    QueryExamples.getAllStations()
    QueryExamples.getRouteStations()
}
