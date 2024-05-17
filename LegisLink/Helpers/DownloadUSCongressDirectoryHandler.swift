//
//  DownloadUSCongressDirectory.swift
//  LegisLink
//
//  Created by Mason Cochran on 5/4/24.
//

import Foundation
import AWSS3
import ClientRuntime
import AWSClientRuntime

//        let sortLegislationByPolicyAreaHelper = SortLegislationByPolicyAreaHelper(senatorOne: self.senatorOne, senatorTwo: self.senatorTwo, representative: self.representative)


public class DownloadUSCongressDirectoryHandler {
    let client: S3Client
    var names = [String]()

    
    /// Initialize and return a new ``ServiceHandler`` object, which is used to drive the AWS calls
    /// used for the example.
    ///
    /// - Returns: A new ``ServiceHandler`` object, ready to be called to
    ///            execute AWS operations.
    // snippet-start:[s3.swift.basics.handler.init]
        
    public init() async {
        
        do {
            client = try S3Client(region: "us-east-2")
        } catch {
            print("ERROR: ", dump(error, name: "Initializing S3 client"))
            exit(1)
        }
        
        do {
            try await self.names = listBucketFiles(bucket: "us-congress-bucket")
            print(self.names)
        } catch {
            print("ERROR: ", dump(error, name: "Fetching Bucket File Names"))
            exit(1)
        }
        
        do {
            try await downloadFiles(files:self.names)
        } catch {
            print("ERROR: ", dump(error, name: "Downloading Files"))
            exit(1)
        }
    }
        
        
  
    
    public func listBucketFiles(bucket: String) async throws -> [String] {
            let input = ListObjectsV2Input(
                bucket: bucket
            )
            let output = try await client.listObjectsV2(input: input)
            var names: [String] = []
        

            guard let objList = output.contents else {
                return []
            }

            for obj in objList {
                if let objName = obj.key {
                    names.append(objName)
                }
            }

            return names
        }
    
    
    public func downloadFiles(files: [String]) async throws {
        let documentDirectoryURL = URL.documentsDirectory

        
        for fileName in files {
            var fileURL = documentDirectoryURL.appendingPathComponent(fileName)

            let input = GetObjectInput(
                bucket: "us-congress-bucket",
                key: fileName
            )
            
            let output = try await client.getObject(input: input)

            // Get the data stream object. Return immediately if there isn't one.
            guard let body = output.body,
                  let data = try await body.readData() else {
                return
            }
                        
            try data.write(to: fileURL)
        }
        
        



        }
    
    
    
}


