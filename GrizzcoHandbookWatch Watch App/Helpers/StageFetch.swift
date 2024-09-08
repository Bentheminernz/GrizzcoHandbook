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
#if DEBUG
static let example = SalmonRunSetting(
    coopStage: SalmonRunStage(
        id: "1",
        name: "Salmonid Smokeyard",
        thumbnailImage: SalmonRunStage.ImageURL(url: "https://splatoon3.ink/assets/splatnet/v2/stage_img/icon/low_resolution/630d89698e3e260ef12cb2a32e1cb2c4c83c0e58fc882762da1fa2cea19a5260_1.png"),
        image: SalmonRunStage.ImageURL(url: "https://splatoon3.ink/assets/splatnet/v2/stage_img/icon/high_resolution/630d89698e3e260ef12cb2a32e1cb2c4c83c0e58fc882762da1fa2cea19a5260_0.png")
    ),
    weapons: [
        Weapon(name: "Recycled Brella 24 Mk I", image: Weapon.ImageURL(url: "https://splatoon3.ink/assets/splatnet/v2/weapon_illust/1e62c90d72a8c11a91ca85be6fe6a3042514e1d77bd01ed65c22ef8e7256809a_0.png")),
        Weapon(name: "Splash-o-matic", image: Weapon.ImageURL(url: "https://splatoon3.ink/assets/splatnet/v2/weapon_illust/25e98eaba1e17308db191b740d9b89e6a977bfcd37c8dc1d65883731c0c72609_0.png")),
        Weapon(name: "Splat Roller", image: Weapon.ImageURL(url: "https://splatoon3.ink/assets/splatnet/v2/weapon_illust/536b28d9dd9fc6633a4bea4a141d63942a0ba3470fc504e5b0d02ee408798a87_0.png")),
        Weapon(name: "Tri-Stringer", image: Weapon.ImageURL(url: "https://splatoon3.ink/assets/splatnet/v2/weapon_illust/676d9f49276f171a93ac06646c0fbdfbeb8c3d0284a057aee306404a6034ffef_0.png"))
    ],
    boss: SalmonRunSetting.Boss(
        name: "Horrorboros",
        image: nil
    )
)
#endif
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
        let userAgent = "GrizzcoHandbook/1.2 (BenLawrence-benlawrencenz@icloud.com)"
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
