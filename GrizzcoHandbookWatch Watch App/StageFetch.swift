//StageFetch.swift

import Foundation

// Data models
struct SalmonRunStage: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnailImage: ImageURL?
    let image: ImageURL?

    struct ImageURL: Codable {
        let url: String
    }
}

struct SalmonRunSetting: Codable, Identifiable {
    let id = UUID() // Added ID for Identifiable conformance
    let coopStage: SalmonRunStage
    let weapons: [Weapon]
    let boss: Boss?

    struct Weapon: Codable {
        let name: String
        let image: ImageURL

        struct ImageURL: Codable {
            let url: String
        }
    }

    struct Boss: Codable {
        let name: String
        let image: ImageURL?

        struct ImageURL: Codable {
            let url: String
        }
    }
}

struct EggstraWorkSetting: Codable, Identifiable {
    let id = UUID() // Added ID for Identifiable conformance
    let coopStage: SalmonRunStage
    let weapons: [Weapon]

    struct Weapon: Codable {
        let name: String
        let image: ImageURL

        struct ImageURL: Codable {
            let url: String
        }
    }
}

struct ScheduleNode: Codable, Identifiable {
    let id = UUID() // Added ID for Identifiable conformance
    let setting: SalmonRunSetting
    let startTime: String
    let endTime: String
}

struct EggstraWorkNode: Codable, Identifiable {
    let id = UUID() // Added ID for Identifiable conformance
    let setting: EggstraWorkSetting
    let startTime: String
    let endTime: String
}

// Fetcher class
class StageFetcher: ObservableObject {
    @Published var currentSalmonRunSetting: SalmonRunSetting?
    @Published var nextScheduleStartTime: Date?
    @Published var salmonRunSettings: [ScheduleNode] = []
    @Published var eggstraWorkSettings: [EggstraWorkNode] = []

    private let lastMapSettingKey = "lastMapSetting"
    private var timer: Timer?

    init() {
        fetchData()
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.fetchData()
        }
    }

    func fetchData() {
        guard let url = URL(string: "https://splatoon3.ink/data/schedules.json") else { return }

        var request = URLRequest(url: url)
        let userAgent = "GrizzcoHandbook/1.0 (BenLawrence-benlawrencenz@icloud.com)"
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ScheduleResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.salmonRunSettings = decodedData.data.coopGroupingSchedule.regularSchedules.nodes
                        if let setting = decodedData.data.coopGroupingSchedule.regularSchedules.nodes.first?.setting {
                            self.currentSalmonRunSetting = setting
                        } else {
                            print("Error: Salmon Run setting not found.")
                        }

                        if let nextStartTimeString = decodedData.data.coopGroupingSchedule.regularSchedules.nodes.dropFirst().first?.startTime {
                            self.nextScheduleStartTime = ISO8601DateFormatter().date(from: nextStartTimeString)
                        }

                        // Handle Eggstra Work
                        if let eggstraWorkNodes = decodedData.data.coopGroupingSchedule.teamContestSchedules?.nodes {
                            self.eggstraWorkSettings = eggstraWorkNodes
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// Schedule Response
struct ScheduleResponse: Codable {
    let data: ScheduleData

    struct ScheduleData: Codable {
        let coopGroupingSchedule: CoopGroupingSchedule

        struct CoopGroupingSchedule: Codable {
            let regularSchedules: RegularSchedules
            let teamContestSchedules: TeamContestSchedules?

            struct RegularSchedules: Codable {
                let nodes: [ScheduleNode]
            }

            struct TeamContestSchedules: Codable {
                let nodes: [EggstraWorkNode]?
            }
        }
    }
}
