
import OpenAPIURLSession

final class QueryExamples {
    static func getNearestStations() {
        Task {
            do {
                let client = getClient()
                let service = NearestStationService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching station...")
                let station = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print("Successfully fetched stations: \(station)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    static func getCarrierInfo() {
        Task {
            do {
                let client = getClient()
                let service = CarrierInfoService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching carrier info...")
                let carrierInfo: CarrierInfo = try await service.getCarrierInfo(
                    code: "680"
                )
                print("Successfully fetched carrier info: \(carrierInfo)")
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
    
    static func getCopyright() {
        Task {
            do {
                let client = getClient()
                let service = CopyrightService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching copyright...")
                let copyright = try await service.getCopyright()
                print("Successfully fetched copyright: \(copyright)")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    
    static func getNearestCity() {
        Task {
            do {
                let client = getClient()
                let service = NearestSettlementService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching nearest city...")
                let nearestCity = try await service.getNearestCity(
                    lat: 54.513678, lng: 36.261341
                )
                print("Successfully nearest city: \(nearestCity)")
            } catch {
                print("Error fetching nearest city: \(error)")
            }
        }
    }
    
    static func getStationSchedule() {
        Task {
            do {
                let client = getClient()
                let service = ScheduleService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching station schedule...")
                let schedule = try await service.getStationSchedule(
                    station: "s9600213"
                )
                print("Successfully fetched station schedule: \(schedule)")
            } catch {
                print("Error fetching station schedule: \(error)")
            }
        }
    }
    
    static func getScheduleBetweenStations() {
        Task {
            do {
                let client = getClient()
                let service = SearchService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching search...")
                let search = try await service.getScheduleBetweenStations(
                    from: "c146", to: "c213", date: "2026-04-08"
                )
                print("Successfully fetched search: \(search)")
            } catch {
                print("Error fetching search: \(error)")
            }
        }
    }
    
    static func getAllStations() {
        Task {
            do {
                let client = getClient()
                let service = StationListService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching station list...")
                let stationsList = try await service.getAllStations()
                let countries = stationsList.countries?.map(\.title) ?? []
                print("Successfully fetched stationsList: \(countries)")
                let countriesCount = stationsList.countries?.count ?? 0
                print("Successfully fetched \(countriesCount) countries")
            } catch {
                print("Error fetching station list: \(error)")
            }
        }
    }
    
    static func getRouteStations() {
        Task {
            do {
                let client = getClient()
                let service = ThreadService(
                    client: client,
                    apiKey: ApiParams.apiKey
                )
                
                print("Fetching thread...")
                let thread = try await service.getRouteStations(uid: "SU-1484_260430_c26_12")
                print("Successfully fetched thread: \(thread)")
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    private static func getClient() -> Client {
        do {
            return Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        } catch {
            print("Couldn't create client: \(error)")
            preconditionFailure()
        }
    }
}
