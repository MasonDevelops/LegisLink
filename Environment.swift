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
        static let openSecretsAPI = "OPEN_SECRETS_API_KEY"
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
            fatalError("app name not found")
        }
        return openSecretsAPIString
    }()
    
}









