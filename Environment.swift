//
//  Environment.Swift
//  LegisLink
//
//  Created by Mason Cochran on 5/29/24.
//

import Foundation

public enum Environment {
    
    enum Keys {
        static let appName = "APP_NAME"
        static let googleCivicInformationAPI = "GOOGLE_API_KEY"
        static let openSecretsAPI = "OPEN_SECRETS_API_KEY"
        static let openStatesAPI = "OPEN_STATES_API_KEY"
        static let congressGovAPI = "CONGRESS_GOV_API_KEY"
        static let nytAPI = "NYT_API_KEY"


    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let appName: String = {
        guard let appNameString = Environment.infoDictionary[Keys.appName] as? String else {
            fatalError("app name not found")
        }
        return appNameString
    }()
    
    
    static let openSecretsAPI: String = {
        guard let openSecretsAPIString = Environment.infoDictionary[Keys.openSecretsAPI] as? String else {
            fatalError("open secrets api key not found")
        }
        return openSecretsAPIString
    }()
    
    static let googleCivicInformationAPI: String = {
        guard let googleCivicInformationAPIString = Environment.infoDictionary[Keys.googleCivicInformationAPI] as? String else {
            fatalError("google api key not found")
        }
        
        return googleCivicInformationAPIString
    }()
    
    static let openStatesAPI: String = {
        guard let openStatesAPIString = Environment.infoDictionary[Keys.openStatesAPI] as? String else {
            fatalError("open states api key not found")
        }
        
        return openStatesAPIString
    }()
    
    static let congressGovAPI: String = {
        guard let congressGovAPIString = Environment.infoDictionary[Keys.congressGovAPI] as? String else {
            fatalError("congress gov api key not found")
        }
        
        return congressGovAPIString
    }()
    
    static let nytAPI: String = {
        guard let nytAPIString = Environment.infoDictionary[Keys.nytAPI] as? String else {
            fatalError("nyt api key not found")
        }
        
        return nytAPIString
    }()
    
}









