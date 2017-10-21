//
//  CJSONSerializer.h
//  TouchCode
//
//  Created by Jonathan Wight on 12/07/2005.
//  Copyright 2005 toxicsoftware.com. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

//     ========================To transform JSON to objects===============
//Basic usage
//
//Put #import "CJSONDeserializer.h" in your source file.
//
//NSData *theJSONData = /* some JSON data */
//NSError *theError = nil;
//id theObject = [[CJSONDeserializer deserializer] deserialize:theJSONData error:&theError];}
//
//This will convert an NSData object containing JSON into an object. The resulting object's class depends on the type of JSON data in question. If the object is NULL then deserialization has failed and you should check the error parameter.
//
//The following, slightly more complex example shows how to convert an NSString containing a JSON dictionary into an NSDictionary:
//
//NSString *jsonString = @"yourJSONHere";
//NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//NSError *error = nil;
//NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
//
//This deserialization will fail if the JSON root object is not a dictionary. Again check the error.
//Using an NSDictionary category
//
//Put #include "NSDictionary_JSONExtensions.h" in your source file.
//
//NSString *theJSONString = @"{\"key\":\"value\"}";
//NSError *theError = NULL;
//NSDictionary *theDictionary = [NSDictionary dictionaryWithJSONString:theJSONString error:&theError];
//
//This version of the code could be considered more convenient than the above former examples.
//Avoiding NSNull values in output.
//
//If your input JSON data contains null values these values will, by default, be represented by NSNull in your output ObjC objects. The following example shows you how to avoid NSNull values in your output:
//
//NSData *theJSONData = /* some JSON data */
//CJSONDeserializer *theDeserializer = [CJSONDeserializer deserializer];
//theDeserializer.nullObject = NULL;
//NSError *theError = nil;
//id theObject = [theDeserializer deserialize:theJSONData error:&theError];}
//
//To transform objects to JSON
//
//Put #import "CJSONDataSerializer.h" in your file.
//
//Here is a code sample:
//
//NSDictionary *dictionary = [NSDictionary dictionaryWithObject:@"b" forKey:@"a"];
//NSError *error = NULL;
//NSData *jsonData = [[CJSONSerializer serializer] serializeObject:dictionary error:&error];



#import <Foundation/Foundation.h>

enum {
    kJSONSerializationOptions_EncodeSlashes = 0x01,
};
typedef NSUInteger EJSONSerializationOptions;


@interface CJSONSerializer : NSObject {
}

@property (readwrite, nonatomic, assign) EJSONSerializationOptions options;

+ (CJSONSerializer *)serializer;

- (BOOL)isValidJSONObject:(id)inObject;

/// Take any JSON compatible object (generally NSNull, NSNumber, NSString, NSArray and NSDictionary) and produce an NSData containing the serialized JSON.
- (NSData *)serializeObject:(id)inObject error:(NSError **)outError;

- (NSData *)serializeNull:(NSNull *)inNull error:(NSError **)outError;
- (NSData *)serializeNumber:(NSNumber *)inNumber error:(NSError **)outError;
- (NSData *)serializeString:(NSString *)inString error:(NSError **)outError;
- (NSData *)serializeArray:(NSArray *)inArray error:(NSError **)outError;
- (NSData *)serializeDictionary:(NSDictionary *)inDictionary error:(NSError **)outError;

@end

extern NSString *const kJSONSerializerErrorDomain /* = @"CJSONSerializerErrorDomain" */;

typedef enum {
    CJSONSerializerErrorCouldNotSerializeDataType = -1,
    CJSONSerializerErrorCouldNotSerializeObject = -2,
} CJSONSerializerError;
