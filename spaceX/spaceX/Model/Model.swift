//
//  Model.swift
//  spaceX
//
//  Created by Milan on 08/10/22.
//

import Foundation

typealias TestModel = [TestModelElement]

// MARK: - TestModelElement
struct TestModelElement: Codable {
    var flightNumber: Int?
    var missionName: String?
    var missionID: [String]?
    var upcoming: Bool?
    var launchYear: String?
    var launchDateUnix: Int?
    var launchDateUTC: String?
    var launchDateLocal: String?
    var isTentative: Bool?
    var tentativeMaxPrecision: String?
    var tbd: Bool?
    var launchWindow: Int?
    var rocket: Rocket?
    var ships: [String]?
    var telemetry: Telemetry?
    var launchSite: LaunchSite?
    var launchSuccess: Bool?
    var launchFailureDetails: LaunchFailureDetails?
    var links: Links?
    var details, staticFireDateUTC: String?
    var staticFireDateUnix: Int?
    var timeline: [String: Int?]?
//    var crew: [JSONAny]?
    var lastDateUpdate: String?
    var lastLlLaunchDate, lastLlUpdate: String?
    var lastWikiLaunchDate, lastWikiRevision, lastWikiUpdate: String?
    var launchDateSource: String?

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case missionID = "mission_id"
        case upcoming
        case launchYear = "launch_year"
        case launchDateUnix = "launch_date_unix"
        case launchDateUTC = "launch_date_utc"
        case launchDateLocal = "launch_date_local"
        case isTentative = "is_tentative"
        case tentativeMaxPrecision = "tentative_max_precision"
        case tbd
        case launchWindow = "launch_window"
        case rocket, ships, telemetry
        case launchSite = "launch_site"
        case launchSuccess = "launch_success"
        case launchFailureDetails = "launch_failure_details"
        case links, details
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case timeline
//        case crew
        case lastDateUpdate = "last_date_update"
        case lastLlLaunchDate = "last_ll_launch_date"
        case lastLlUpdate = "last_ll_update"
        case lastWikiLaunchDate = "last_wiki_launch_date"
        case lastWikiRevision = "last_wiki_revision"
        case lastWikiUpdate = "last_wiki_update"
        case launchDateSource = "launch_date_source"
    }
}


// MARK: - LaunchFailureDetails
struct LaunchFailureDetails: Codable {
    var time: Int?
    var altitude: Int?
    var reason: String?
}

// MARK: - LaunchSite
struct LaunchSite: Codable {
    var siteID: SiteID?
    var siteName: SiteName?
    var siteNameLong: SiteNameLong?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}

enum SiteID: String, Codable {
    case ccafsSlc40 = "ccafs_slc_40"
    case kscLc39A = "ksc_lc_39a"
    case kwajaleinAtoll = "kwajalein_atoll"
    case vafbSlc4E = "vafb_slc_4e"
}

enum SiteName: String, Codable {
    case ccafsSlc40 = "CCAFS SLC 40"
    case kscLc39A = "KSC LC 39A"
    case kwajaleinAtoll = "Kwajalein Atoll"
    case vafbSlc4E = "VAFB SLC 4E"
}

enum SiteNameLong: String, Codable {
    case capeCanaveralAirForceStationSpaceLaunchComplex40 = "Cape Canaveral Air Force Station Space Launch Complex 40"
    case kennedySpaceCenterHistoricLaunchComplex39A = "Kennedy Space Center Historic Launch Complex 39A"
    case kwajaleinAtollOmelekIsland = "Kwajalein Atoll Omelek Island"
    case vandenbergAirForceBaseSpaceLaunchComplex4E = "Vandenberg Air Force Base Space Launch Complex 4E"
}

// MARK: - Links
struct Links: Codable {
    var missionPatch, missionPatchSmall: String?
    var redditCampaign: String?
    var redditLaunch: String?
    var redditRecovery, redditMedia: String?
    var presskit: String?
    var articleLink: String?
    var wikipedia, videoLink: String?
    var youtubeID: String?
    var flickrImages: [String]?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case youtubeID = "youtube_id"
        case flickrImages = "flickr_images"
    }
}

// MARK: - Rocket
struct Rocket: Codable {
    var rocketID: String?
    var rocketName: String?
    var rocketType: String?
    var firstStage: FirstStage?
    var secondStage: SecondStage?
    var fairings: Fairings?

    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case fairings
    }
}

// MARK: - Fairings
struct Fairings: Codable {
    var reused, recoveryAttempt, recovered: Bool?
    var ship: String?

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered, ship
    }
}

// MARK: - FirstStage
struct FirstStage: Codable {
    var cores: [Core]?
}

// MARK: - Core
struct Core: Codable {
    var coreSerial: String?
    var flight, block: Int?
    var gridfins, legs, reused, landSuccess: Bool?
    var landingIntent: Bool?
    var landingType: String?
    var landingVehicle: String?

    enum CodingKeys: String, CodingKey {
        case coreSerial = "core_serial"
        case flight, block, gridfins, legs, reused
        case landSuccess = "land_success"
        case landingIntent = "landing_intent"
        case landingType = "landing_type"
        case landingVehicle = "landing_vehicle"
    }
}


// MARK: - SecondStage
struct SecondStage: Codable {
    var block: Int?
    var payloads: [Payload]?
}

// MARK: - Payload
struct Payload: Codable {
    var payloadID: String?
    var noradID: [Int]?
    var reused: Bool?
    var customers: [String]?
    var nationality: String?
    var manufacturer: String?
    var payloadType: String?
    var payloadMassKg, payloadMassLbs: Double?
    var orbit: String?
    var orbitParams: OrbitParams?
    var capSerial: String?
    var massReturnedKg, massReturnedLbs: Double?
    var flightTimeSEC: Int?
    var cargoManifest: String?
    var uid: String?

    enum CodingKeys: String, CodingKey {
        case payloadID = "payload_id"
        case noradID = "norad_id"
        case reused, customers, nationality, manufacturer
        case payloadType = "payload_type"
        case payloadMassKg = "payload_mass_kg"
        case payloadMassLbs = "payload_mass_lbs"
        case orbit
        case orbitParams = "orbit_params"
        case capSerial = "cap_serial"
        case massReturnedKg = "mass_returned_kg"
        case massReturnedLbs = "mass_returned_lbs"
        case flightTimeSEC = "flight_time_sec"
        case cargoManifest = "cargo_manifest"
        case uid
    }
}

// MARK: - OrbitParams
struct OrbitParams: Codable {
    var referenceSystem: String?
    var regime: String?
    var longitude, semiMajorAxisKM, eccentricity, periapsisKM: Double?
    var apoapsisKM, inclinationDeg, periodMin, lifespanYears: Double?
    var epoch: String?
    var meanMotion, raan, argOfPericenter, meanAnomaly: Double?

    enum CodingKeys: String, CodingKey {
        case referenceSystem = "reference_system"
        case regime, longitude
        case semiMajorAxisKM = "semi_major_axis_km"
        case eccentricity
        case periapsisKM = "periapsis_km"
        case apoapsisKM = "apoapsis_km"
        case inclinationDeg = "inclination_deg"
        case periodMin = "period_min"
        case lifespanYears = "lifespan_years"
        case epoch
        case meanMotion = "mean_motion"
        case raan
        case argOfPericenter = "arg_of_pericenter"
        case meanAnomaly = "mean_anomaly"
    }
}

// MARK: - Telemetry
struct Telemetry: Codable {
    var flightClub: String?

    enum CodingKeys: String, CodingKey {
        case flightClub = "flight_club"
    }
}


